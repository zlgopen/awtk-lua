function show_preload_res_window()
  local win = Window.open('preload');
end

function application_init()
  show_preload_res_window()
end

tk_ext_widgets_init()
application_init()


