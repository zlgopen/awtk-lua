# awtk-lua

awtk lua bindings.

## 准备

1.获取awtk并编译

```
git clone https://github.com/zlgopen/awtk.git
cd awtk; scons; cd -
```

2.获取awtk-lua并编译

```
git clone https://github.com/zlgopen/awtk-lua.git
cd awtk-lua
```

* 生成资源

```
python ./scripts/update_res.py all
```

> 或者通过 designer 生成资源


* 编译PC版本

```
scons
```

* 编译LINUX FB版本

```
scons LINUX_FB=true
```

> 完整编译选项请参考[编译选项](https://github.com/zlgopen/awtk-widget-generator/blob/master/docs/build_options.md)


## 更新绑定

```
./sync.sh
```

> 在非bash终端(如Windows平台的cmd.exe)，需要根据sync.sh的内容手工执行相应的命令。

## 运行

```
./bin/awtkRun demos/xxxx.lua
```
> 请把xxxx.lua换成具体的lua文件。

## 文档

[lua绑定原理与示例](docs/binding_lua.md)

> 本文以Linux/MacOS为例，Windows可能会微妙差异，请酌情处理。
