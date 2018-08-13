# awtk-lua

awtk lua bindings.

## 一、准备

```
git clone https://github.com/zlgopen/awtk.git

git clone https://github.com/zlgopen/awtk-lua.git

cd awtk-lua
```


## 二、更新绑定

```
cd tools/lua_gen/
node index.js 
```

## 三、编译

```
scons
```

## 四、运行

```
./bin/runScript demos/xxxx.lua
```

## 文档

[lua绑定原理与示例](docs/binding_lua.md)
