
function create_check_button(win, radio, text, x, y, w, h)
  local btn = nil;
  
  if(radio)
  then
    btn = CheckButton.create_radio(win, x, y, w, h);
  else
    btn = CheckButton.create(win, x, y, w, h);
  end

  btn:on(EventType.VALUE_CHANGED, function(evt) 
    print(btn.name .. ' changed: ' .. tostring(btn.value))
    return Ret.OK;
  end);

  btn:set_name(text);
  btn:set_text_utf8(text);

  return btn;
end

function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);

  local btn1 = create_check_button(win, false, 'Zzzzzz', 10, 10, 128, 30);
  local btn2 = create_check_button(win, false, 'Lzzzzz', 10, 50, 128, 30);
  local btn3 = create_check_button(win, false, 'Gzzzzz', 10, 90, 128, 30);
   
  local btn4 = create_check_button(win, true, 'Aaaaaa', 10, 10+128, 128, 30);
  local btn5 = create_check_button(win, true, 'Waaaaa', 10, 50+128, 128, 30);
  local btn6 = create_check_button(win, true, 'Tttttt', 10, 90+128, 128, 30);
  local btn7 = create_check_button(win, true, 'Kkkkkk', 10, 130+128, 128, 30);

  win:layout();
end

application_init()


