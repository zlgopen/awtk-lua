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

extern void luaL_openawtk(lua_State* L);

static lua_State* L = NULL;
static const char* script_file = NULL;

static ret_t on_cmd_line(int argc, char* argv[]) {
  script_file = argc == 2 ? argv[1] : "./demos/demoui.lua";

  return RET_OK;
}

static ret_t application_init() {
  L = luaL_newstate();
  luaL_openlibs(L);
  luaL_openawtk(L);

  if (luaL_dofile(L, script_file)) {
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    lua_pop(L, 1);
    exit(0);
  }

  return RET_OK;
}

static ret_t application_exit() {
  lua_close(L);

  return RET_OK;
}

#define APP_NAME "AWTK-LUA"
#define ON_CMD_LINE on_cmd_line

#include "../res/assets.inc"
#include "awtk_main.inc"
