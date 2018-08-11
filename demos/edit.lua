
function on_changed(evt) 
  local target = evt.target;
  local edit = Edit.cast(target);

  print(edit.name .. ' *on_changed*');

  return Ret.OK;
end

function create_edit(win, type, name, text, x, y, w, h)
  local edit = Edit.create(win, x, y, w, h);

  edit:on(EventType.VALUE_CHANGED, function(evt) 
    print(edit.name .. ' changed');
    return Ret.OK;
  end);
  
  edit:on(EventType.VALUE_CHANGING, function(evt) 
    print(edit.name .. ' changing');
    return Ret.OK;
  end);
  
  edit:on(EventType.VALUE_CHANGED, on_changed);

  edit:set_name(name);
  edit:set_text(text);
  edit:set_input_tips(name);
  edit:set_input_type(type);

  return edit;
end

function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);

  local edit1 = create_edit(win, InputType.TEXT, 'text[3-8]', '', 10, 10, 228, 30);
  edit1:set_text_limit(3, 8);

  local edit2 = create_edit(win, InputType.INT, 'int auto fix[1-100]', '', 10, 50, 228, 30);
  edit2:set_int_limit(1, 100, 1);
  edit2:set_auto_fix(true);

  local edit3 = create_edit(win, InputType.FLOAT, 'float[1-10]', '1.23', 10, 90, 228, 30);
  edit3:set_float_limit(1, 10, 1);

  local edit4 = create_edit(win, InputType.PASSWORD, 'password', '', 10, 10+128, 228, 30);
  local edit5 = create_edit(win, InputType.TEXT, 'text', 'readonly', 10, 50+128, 228, 30);
  edit5:set_readonly(true);

  local edit6 = create_edit(win, InputType.HEX, 'hex', '', 10, 90+128, 228, 30);
  local edit7 = create_edit(win, InputType.EMAIL, 'email', '', 10, 130+128, 228, 30);

  win:layout();
end

application_init()


