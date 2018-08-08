
s_preload_res = {
  {type = ResourceType.IMAGE, name = "bg800x480"},
  {type = ResourceType.IMAGE, name = "earth"},
  {type = ResourceType.IMAGE, name = "dialog_title"},
  {type = ResourceType.IMAGE, name = "rgb"},
  {type = ResourceType.IMAGE, name = "rgba"}
}

function str_contains(str, substr) 
  local s, e = string.find(str, substr);

  return s ~= nil;
end

function install_one(iter) 
  local widget_name = iter.name;
  if(str_contains(widget_name, 'open'))
  then
    iter:on(EventType.CLICK, function(evt)
      local name = string.sub(iter.name, 6);
      open_window(name, nil);
    end)
    print('open window:' .. widget_name);
  elseif(str_contains(widget_name, 'close'))
  then
    iter:on(EventType.CLICK, function(evt)
      iter:get_window():close();
    end)
    print('close window:' .. widget_name);
  elseif(str_contains(widget_name, 'quit'))
  then
    iter:on(EventType.CLICK, function(evt)
      iter:get_window():quit(0);
    end)
    print('quit dialog:' .. widget_name);
  elseif(str_contains(widget_name, 'chinese'))
  then
    iter:on(EventType.CLICK, function(evt)
      Tklocale.instance():change('zh', 'CN');
    end)
  elseif(str_contains(widget_name, 'english'))
  then
    iter:on(EventType.CLICK, function(evt)
      Tklocale.instance():change('en', 'US');
    end)
  elseif(str_contains(widget_name, 'show_fps'))
  then
    iter:on(EventType.CLICK, function(evt)
      local wm = WindowManager.instance();
      print(wm.show_fps)
      if(wm.show_fps)
      then
        wm:set_show_fps(false);
        iter:set_text_utf8("Show FPS");
      else
        wm:set_show_fps(true);
        iter:set_text_utf8("Hide FPS");
      end
    end)
    print('close window:' .. widget_name);
  end

  return Ret.OK;
end

function install_handlers(win)
  print('install_handlers');
  win:foreach(install_one);
end

function open_window(name, to_close)
  local win = nil;
  if(to_close)
  then
    win = Window.open_and_close(name, to_close);
  else
    win = Window.open(name);
  end

  install_handlers(win);

  print(win:get_type() .. ':' .. WidgetType.DIALOG);

  if(win:get_type() == WidgetType.DIALOG)
  then
    print('win:modal');
    Dialog.cast(win):modal();
  end
end

function show_preload_res_window()
  local win = Window.open('preload');
  local interval = 500 / #s_preload_res; 
  local bar = win:lookup('bar', TRUE);
  local status = win:lookup('status', TRUE);
  local total = #s_preload_res
  local finish = 0;
  local bitmap = Bitmap.create();

  status:set_text_utf8('ready');
  bar:set_value(10);

  Timer.add(function(info) 
    if(finish == total)
    then
      print('done')
      open_window('main', win);
      bitmap:destroy();

      return Ret.REMOVE;
    else
      local type = s_preload_res[finish+1].type;
      local name = s_preload_res[finish+1].name;

      if(type == ResourceType.IMAGE)
      then
        ImageManager.instance():load(name, bitmap);
      end

      finish = finish + 1;
      local value = finish * 100 / total;
      local text = 'Load: ' .. name .. '(' .. tostring(finish) .. '/' .. tostring(total) .. ')';
      
      bar:set_value(value);
      status:set_text_utf8(text);

      return Ret.REPEAT;
    end
  end, interval);

end

function application_init()
  show_preload_res_window()
end

tk_ext_widgets_init()
application_init()


