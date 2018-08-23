/**
 * File:   run_lua.c
 * Author: AWTK Develop Team
 * Brief:  entry of lua awtk
 *
 * Copyright (c) 2018 - 2018  Guangzhou ZHIYUAN Electronics Co.,Ltd.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * License file for more details.
 *
 */

/**
 * History:
 * ================================================================
 * 2018-08-06 Li XianJing <xianjimli@hotmail.com> created
 *
 */
#include <lua/lua.h>
#include <lua/lauxlib.h>
#include <lua/lualib.h>

#include "awtk.h"
#include "demos/assets.h"
#include "ext_widgets/ext_widgets.h"

extern void luaL_openawtk(lua_State* L);

int main(int argc, char* argv[]) {
  lua_State* L = luaL_newstate();
  const char* lua_file = argc == 2 ? argv[1] : "./demos/demoui.lua";

  luaL_openlibs(L);
  luaL_openawtk(L);

  tk_init(320, 480, APP_SIMULATOR, NULL, RES_ROOT);
  tk_ext_widgets_init();
  assets_init();

  if (luaL_dofile(L, lua_file)) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    lua_pop(L, 1);
  } else {
    tk_run();
  }

  lua_close(L);

  return 0;
}
