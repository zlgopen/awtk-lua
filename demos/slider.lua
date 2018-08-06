
function create_progress_bar(win, vertical, name)
  local slider = Slider.create(win, 0, 0, 0, 0);

  slider:on(EventType.VALUE_CHANGED, function(evt) 
    print(slider.name .. ' changed: ' .. slider.value);
    return Ret.OK;
  end);
  
  slider:on(EventType.VALUE_CHANGING, function(evt) 
    print(slider.name .. ' changing: ' .. slider.value);
    return Ret.OK;
  end);

  slider:set_name(name);
  slider:set_value(10);
  slider:set_vertical(vertical);

  if(vertical)
  then
    slider:set_self_layout_params("center", "10", "20", "80%");
  else
    slider:set_self_layout_params("center", "bottom:10", "90%", "20");
  end

  return slider;
end

function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local slider1 = create_progress_bar(win, false, 'slider1');
  local slider2 = create_progress_bar(win, true, 'slider2');

  win:layout();
end

application_init()


