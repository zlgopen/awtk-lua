import os
import platform

OS_NAME=platform.system()
TK_LUA_ROOT = os.path.normpath(os.getcwd())
TK_LUA_3RD_ROOT = os.path.join(TK_LUA_ROOT, '3rd')
TK_LUA_BIN_DIR=os.path.join(TK_LUA_ROOT, 'bin')
TK_LUA_LIB_DIR=os.path.join(TK_LUA_ROOT, 'lib')

TK_ROOT = os.path.normpath(os.getcwd()+'/../awtk')
TK_SRC = os.path.join(TK_ROOT, 'src')
TK_3RD_ROOT = os.path.join(TK_ROOT, '3rd')
TK_TOOLS_ROOT = os.path.join(TK_ROOT, 'tools')
TK_BIN_DIR=os.path.join(TK_ROOT, 'bin')
TK_LIB_DIR=os.path.join(TK_ROOT, 'lib')

os.environ['TK_LUA_ROOT'] = TK_LUA_ROOT;
os.environ['BIN_DIR'] = TK_LUA_BIN_DIR;
os.environ['LIB_DIR'] = TK_LUA_LIB_DIR;

os.environ['TK_ROOT'] = TK_ROOT;
os.environ['TK_BIN_DIR'] = TK_BIN_DIR;
os.environ['TK_LIB_DIR'] = TK_LIB_DIR;

OS_LIBPATH=[]
OS_CPPPATH=[]
OS_FLAGS='-g -Wall'
OS_SUBSYSTEM_CONSOLE=''
OS_SUBSYSTEM_WINDOWS=''
OS_LINKFLAGS=''
OS_LIBS=['SDL2', 'glad', 'stdc++', 'pthread', 'm']

COMMON_CCFLAGS = ' -DLUA_COMPAT_MODULE '
if OS_NAME == 'Darwin':
  OS_LINKFLAGS='-framework OpenGL'
  COMMON_CCFLAGS = COMMON_CCFLAGS + ' -DLUA_USE_POSIX -D__APPLE__ -DHAS_PTHREAD -DMACOS'

elif OS_NAME == 'Linux':
  OS_LIBS = ['GL'] + OS_LIBS + ['dl']
  COMMON_CCFLAGS = COMMON_CCFLAGS + ' -DLUA_USE_POSIX -DLINUX -DHAS_PTHREAD'

elif OS_NAME == 'Windows':
  OS_LIBS=['SDL2', 'glad']
  OS_FLAGS='-DWIN32 -D_WIN32 -DWINDOWS /EHsc -D_CONSOLE  /DEBUG -DUNICODE -D_UNICODE /Od /ZI'
  OS_LINKFLAGS='/MACHINE:X64 /DEBUG'
  OS_LIBPATH=[TK_3RD_ROOT+'/SDL2-2.0.7/lib/x64']
  OS_CPPPATH=[TK_3RD_ROOT+'/SDL2-2.0.7/']
  OS_SUBSYSTEM_CONSOLE='/SUBSYSTEM:CONSOLE  '
  OS_SUBSYSTEM_WINDOWS='/SUBSYSTEM:WINDOWS  '
  
LIBS=['awtk', 'gpinyin', 'awtk', 'linebreak', 'nanovg'] + OS_LIBS

CCFLAGS=OS_FLAGS + COMMON_CCFLAGS 
CPPPATH=[TK_ROOT, 
  TK_SRC, 
  TK_3RD_ROOT, 
  TK_LUA_3RD_ROOT,
  os.path.join(TK_SRC, 'ext_widgets'), 
  TK_TOOLS_ROOT] + OS_CPPPATH

LIBPATH = [TK_LIB_DIR, TK_LUA_LIB_DIR]

DefaultEnvironment(CCFLAGS = CCFLAGS, 
  CPPPATH = CPPPATH,
  LIBS=LIBS,
  LINKFLAGS=OS_LINKFLAGS,
  OS_SUBSYSTEM_CONSOLE=OS_SUBSYSTEM_CONSOLE,
  OS_SUBSYSTEM_WINDOWS=OS_SUBSYSTEM_WINDOWS,
  LIBPATH=LIBPATH + OS_LIBPATH)

SConscriptFiles= [
  '3rd/lua/SConscript',
  'src/SConscript'
  ]
  
SConscript(SConscriptFiles)

