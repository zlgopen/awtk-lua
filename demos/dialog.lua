function on_click(evt) 
  local dlg = Dialog.create_simple(nil, 0, 0, 240, 160);

  dlg.title:set_text_utf8('Dialog');

  local ok = Button.create(dlg.client, 20, 80, 80, 30);
  ok:set_text_utf8('Go');

  local cancel = Button.create(dlg.client, 140, 80, 80, 30);
  cancel:set_text_utf8('Cancel');

  local label = Label.create(dlg.client, 10, 30, 200, 30);
  label:set_text_utf8('AWTK is cool!');

  ok:on(EventType.CLICK, function(evt) 
    dlg:quit(1);
    return Ret.OK;
  end)

  cancel:on(EventType.CLICK, function(evt) 
    dlg:quit(2);
    return Ret.OK;
  end)

  local code = dlg:modal();
  print('code=' .. tostring(code));
end

function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local ok = Button.create(win, 0, 0, 0, 0);

  ok:set_text_utf8("Show Dialog");
  ok:set_self_layout_params("center", "middle", "50%", "30");
  ok:on(EventType.CLICK, on_click);

  win:layout();
end

application_init()


