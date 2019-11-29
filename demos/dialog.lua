function on_click(evt) 
  local dlg = Dialog.create_simple(nil, 0, 0, 240, 160);

  dlg:set_title('Dialog');

  local ok = Button.create(dlg:get_client(), 20, 80, 80, 30);
  ok:set_text('Go');

  local cancel = Button.create(dlg:get_client(), 140, 80, 80, 30);
  cancel:set_text('Cancel');

  local label = Label.create(dlg:get_client(), 10, 30, 200, 30);
  label:set_text('AWTK is cool!');

  ok:on(EventType.CLICK, function(evt) 
    dlg:quit(DialogQuitCode.OK);
    return Ret.OK;
  end)

  cancel:on(EventType.CLICK, function(evt) 
    dlg:quit(DialogQuitCode.CANCEL);
    return Ret.OK;
  end)

  local code = dlg:modal();
  print('code=' .. tostring(code));
end

function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);
  local ok = Button.create(win, 0, 0, 0, 0);

  ok:set_text("Show Dialog");
  ok:set_self_layout_params("center", "middle", "50%", "30");
  ok:on(EventType.CLICK, on_click);

  win:layout();
end

application_init()


