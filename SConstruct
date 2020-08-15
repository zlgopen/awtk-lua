import os
import scripts.app_helper as app

ARGUMENTS['FONT'] = 'default_full'
helper = app.Helper(ARGUMENTS);
APP_LIBS=['lua']
APP_CCFLAGS = '-DLUA_COMPAT_MODULE '
APP_CPPPATH = [os.path.join(helper.APP_ROOT, '3rd')]
helper.add_libs(APP_LIBS).add_ccflags(APP_CCFLAGS).add_cpppath(APP_CPPPATH).call(DefaultEnvironment)

SConscriptFiles = ['3rd/lua/SConscript', 'src/SConscript']
SConscript(SConscriptFiles)
