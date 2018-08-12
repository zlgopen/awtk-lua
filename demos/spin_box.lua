
function create_spin_box(win, type, name, text, x, y, w, h)
  local spin_box = SpinBox.create(win, x, y, w, h);

  spin_box:on(EventType.VALUE_CHANGED, function(evt) 
    print(spin_box.name .. ' changed');
    return Ret.OK;
  end);
  
  spin_box:on(EventType.VALUE_CHANGING, function(evt) 
    print(spin_box.name .. ' changing:' .. tostring(spin_box:get_double()));
    return Ret.OK;
  end);

  spin_box:set_name(name);
  spin_box:set_text(text);
  spin_box:set_input_tips(name);
  spin_box:set_input_type(type);

  return spin_box;
end

function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);

  local spin_box1 = create_spin_box(win, InputType.INT, 'int', '', 10, 10, 228, 30);
  spin_box1:set_int_limit(1, 100, 1);

  local spin_box2 = create_spin_box(win, InputType.UINT, 'uint', '', 10, 50, 228, 30);
  spin_box2:set_int_limit(1, 100, 1);

  local spin_box3 = create_spin_box(win, InputType.FLOAT, 'float', '1.23', 10, 90, 228, 30);
  spin_box3:set_float_limit(1, 10, 1);

  local spin_box4 = create_spin_box(win, InputType.UFLOAT, 'ufloat', '', 10, 10+128, 228, 30);
  spin_box4:set_float_limit(1, 10, 0.1);

  win:layout();
end

application_init()


