# AWTK lua绑定原理

## lua绑定

对lua绑定花了一些时间，由于对lua不熟悉，还特意买了两本书，阅读lua的源码也有很大帮助。这里做个笔记，方便有需要的朋友参考：

### 一、全局函数的绑定

这个很多资料里都有介绍。

示例：

* 1.实现wrap函数

```
static int wrap_tk_ext_widgets_init(lua_State* L) {
  ret_t ret = 0;
  ret = (ret_t)tk_ext_widgets_init();

  lua_pushnumber(L, (lua_Number)(ret));

  return 1;
}

```

* 2.注册

```
  lua_pushcfunction(L, wrap_tk_ext_widgets_init);
  lua_setglobal(L, "tk_ext_widgets_init");
```

### 二、构造函数的绑定

* 1.实现wrap函数。构造函数的wrap函数和普通函数的wrap差不多，只是最后要调用awtk\_newuserdata创建一个userdata对象，并关联metatable。我开始用的lua\_pushlightuserdata函数，后来发现lua里全部的ligthuserdata用的是一个metatable，修改一个对象的metatable，其它类型的对象的metatable也被修改了(我感觉这种做法并不合理)。

```
static int wrap_button_create(lua_State* L) {
  widget_t* ret = NULL;
  widget_t* parent = (widget_t*)tk_checkudata(L, 1, "widget_t");
  xy_t x = (xy_t)luaL_checkinteger(L, 2);
  xy_t y = (xy_t)luaL_checkinteger(L, 3);
  wh_t w = (wh_t)luaL_checkinteger(L, 4);
  wh_t h = (wh_t)luaL_checkinteger(L, 5);
  ret = (widget_t*)button_create(parent, x, y, w, h);

  return tk_newuserdata(L, (void*)ret, "/button_t/widget_t", "awtk.button_t");
}

```

* 2.注册

```
static void button_t_init(lua_State* L) {
  static const struct luaL_Reg static_funcs[] = {
      {"create", wrap_button_create}, {"cast", wrap_button_cast}, {NULL, NULL}};

  static const struct luaL_Reg index_funcs[] = {
      {"__index", wrap_button_t_get_prop}, {"__newindex", wrap_button_t_set_prop}, {NULL, NULL}};

  luaL_newmetatable(L, "awtk.button_t");
  lua_pushstring(L, "__index");
  lua_pushvalue(L, -2);
  lua_settable(L, -3);
  luaL_openlib(L, NULL, index_funcs, 0);
  luaL_openlib(L, "Button", static_funcs, 0);
  lua_settop(L, 0);
}
```

### 三、成员函数和获取成员变量的绑定

* 1.实现wrap函数。成员函数的wrap函数和普通函数的wrap差不多。

```
static int wrap_check_button_set_value(lua_State* L) { 
  ret_t ret = 0; 
  widget_t* widget = (widget_t*)tk_checkudata(L, 1, "widget_t");
  uint32_t value = (uint32_t)luaL_checkinteger(L, 2);
  ret = (ret_t)check_button_set_value(widget, value);

  lua_pushnumber(L,(lua_Number)(ret));

  return 1;
}
```

* 2.注册。为了让成员函数能够一级一级的调到父类中去，我使用了lua的\_\_index函数。

先把类的成员函数放到一张表中，方便后面查找。

```
static const struct luaL_Reg check_button_t_member_funcs[] = {
  {"set_text", wrap_check_button_set_text},
  {"set_value", wrap_check_button_set_value},
  {NULL, NULL}
};
```

通过find\_member到上表中查找成员函数，如果找到就直接返回该函数。如果没找到，再看是不是成员变量，是则返回成员变量的值。最后再到父类中去查找，重复这个过程。

```
static int wrap_check_button_t_get_prop(lua_State* L) {
  check_button_t* obj = (check_button_t*)tk_checkudata(L, 1, "check_button_t");
  const char* name = (const char*)luaL_checkstring(L, 2);
  const luaL_Reg* ret = find_member(check_button_t_member_funcs, name);

  (void)obj;
  (void)name;
  if(ret) {
    lua_pushcfunction(L, ret->func);
    return 1;
  }
  if(strcmp(name, "value") == 0) {
    lua_pushboolean(L,(lua_Integer)(obj->value));

  return 1;
  }
  else {
    return wrap_widget_t_get_prop(L);
  }
}

```

注册metatable。

```
  static const struct luaL_Reg index_funcs[] = {
    {"__index", wrap_check_button_t_get_prop},
    {"__newindex", wrap_check_button_t_set_prop},
    {NULL, NULL}
  };
  
  luaL_newmetatable(L, "awtk.check_button_t");
  lua_pushstring(L, "__index");
  lua_pushvalue(L, -2);
  lua_settable(L, -3);
```

### 四、设置成员变量的绑定

这个我是使用\_\_newindex函数来实现的。如果修改readonly的成员会打印警告，否则就直接修改。对于不存在的成员变量，到父类中去查找，重复这个过程。

```
static int wrap_check_button_t_set_prop(lua_State* L) {
  check_button_t* obj = (check_button_t*)tk_checkudata(L, 1, "check_button_t");
  const char* name = (const char*)luaL_checkstring(L, 2);
(void)obj;
(void)name;
  if(strcmp(name, "value") == 0) {
      printf("value is readonly\n");
      return 0;
  }
  else {
    return wrap_widget_t_set_prop(L);
  }
}
```


### 五、枚举的绑定

枚举则是直接创建了一张表，把枚举的值放到表中即可。

```
static void value_type_t_init(lua_State* L) {
  lua_newtable(L);
  lua_setglobal(L, "ValueType");
  lua_getglobal(L, "ValueType");

  lua_pushstring(L, "INVALID");
  lua_pushinteger(L, VALUE_TYPE_INVALID);
  lua_settable(L, -3);
```

### 六、回调函数的处理

回调函数的处理麻烦一点，而且书里没有讲过，所以花了一些功夫。后来发现有回调函数的函数，很难自动产生代码，所幸这样的函数没几个，干脆手写了这部代码(为此在注释的annotation中增加了scriptable:custom关键字，有此关键字的函数则需要手工编写代码)。

```
static ret_t emitter_item_on_destroy(void* data) {
  emitter_item_t* item = (emitter_item_t*)data;
  lua_State* L = (lua_State*)item->on_destroy_ctx;

  uint32_t func = (char*)(item->ctx) - (char*)NULL;
  luaL_unref(L, LUA_REGISTRYINDEX, func);

  return RET_OK;
}

static int wrap_widget_on(lua_State* L) {
  ret_t ret = 0;
  widget_t* widget = (widget_t*)tk_checkudata(L, 1, "widget_t");
  event_type_t type = (event_type_t)luaL_checkinteger(L, 2);

  if (lua_isfunction(L, 3)) {
    int func = 0;
    lua_pushvalue(L, 3);
    func = luaL_ref(L, LUA_REGISTRYINDEX);
    ret = (ret_t)widget_on(widget, type, call_on_event, (char*)NULL + func);
    emitter_set_on_destroy(widget->emitter, ret, emitter_item_on_destroy, L);
    lua_pushnumber(L, (lua_Number)ret);
    return 1;
  } else {
    return 0;
  }
}
```


## lua示例

本例中创建了两个按钮和一个进度条，可以通过按钮来控制进度条的值。

```
function application_init()
  local win = Window.create(nil, 0, 0, 0, 0)
  local inc = Button.create(win, 10, 5, 80, 30) 
  inc:set_text(to_wstr('Inc'));
 
  local dec = Button.create(win, 100, 5, 80, 30);
  dec:set_text(to_wstr('Dec'));
  
  local progress_bar = ProgressBar.create(win, 10, 80, 168, 30);
  progress_bar:set_value(40);
  
  inc:on(EventType.EVT_CLICK, function(evt) 
    local e = PointerEvent.cast(evt);
    progress_bar:set_value(progress_bar.value + 10);
    print('on inc click:(' .. tostring(e.x) .. ' ' .. tostring(e.y) .. ')')
  end);
  
  dec:on(EventType.EVT_CLICK, function(evt) 
    local e = PointerEvent.cast(evt);
    progress_bar:set_value(progress_bar.value - 10);
    print('on dec click:(' .. tostring(e.x) .. ' ' .. tostring(e.y) .. ')')
  end);
end

application_init()
```

## 参考资料

* http://book.luaer.cn
* https://www.lua.org/manual/5.2/
* http://www.cnblogs.com/luweimy/p/3972353.html
