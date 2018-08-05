function on_click(ctx, evt) 
  print('on_click');
end

function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);

  local label = Label.create(win, 100, 5, 80, 30);
  label:set_text_utf8("hello awtk");

end

application_init()


