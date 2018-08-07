function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local label = Label.create(win, 0, 0, 0, 0);

  label:use_style('big_green');
  label:set_text_utf8("hello awtk!");
  label:set_self_layout_params("center", "middle", "50%", "30");

  win:layout();
end

application_init()


