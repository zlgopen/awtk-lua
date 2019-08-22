
function create_combo_box(win, name, options, index, x, y, w, h)
  local box = ComboBoxEx.create(win, x, y, w, h);

  box:on(EventType.VALUE_CHANGED, function(evt) 
    print(box.name .. ' changed: ' .. tostring(box.value))
    return Ret.OK;
  end);

  box:set_name(name);
  box:set_options(options);
  box:set_selected_index(index);

  return box;
end

function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);

  local box1 = create_combo_box(win, 'color', 'Red;Green;Blue', 0, 10, 10, 168, 30);
  local box2 = create_combo_box(win, 'zlg', '0:Zzzzzzzz;1:Lzzzzzzz;2:Gzzzzzzz', 1, 10, 50, 168, 30);
  local box3 = create_combo_box(win, 'awtk', '', 1, 10, 90, 168, 30);
  
  box3:append_option(10, 'Aaaaaaa');
  box3:append_option(20, 'Waaaaaa');
  box3:append_option(30, 'Taaaaaa');
  box3:append_option(40, 'Kaaaaaa');
  box3:append_option(41, 'Kaaaaaa1');
  box3:append_option(42, 'Kaaaaaa2');
  box3:append_option(43, 'Kaaaaaa3');
  box3:append_option(44, 'Kaaaaaa4');
  box3:append_option(45, 'Kaaaaaa5');
  box3:append_option(46, 'Kaaaaaa6');
  box3:append_option(47, 'Kaaaaaa7');
  box3:append_option(48, 'Kaaaaaa8');
  box3:append_option(49, 'Kaaaaaa9');
  box3:set_selected_index(3);

  win:layout();
end

application_init()


