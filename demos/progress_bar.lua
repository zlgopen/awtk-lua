
function create_progress_bar(win, vertical, name)
  local bar = ProgressBar.create(win, 0, 0, 0, 0);

  bar:on(EventType.VALUE_CHANGED, function(evt) 
    print(bar.name .. ' changed: ' .. bar.value);
    return Ret.OK;
  end);

  bar:set_name(name);
  bar:set_value(10);
  bar:set_show_text(true);
  bar:set_vertical(vertical);

  if(vertical)
  then
    bar:set_self_layout_params("center", "10", "30", "80%");
  else
    bar:set_self_layout_params("center", "bottom:10", "90%", "30");
  end

  return bar;
end

function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);
  local bar1 = create_progress_bar(win, false, 'bar1');
  local bar2 = create_progress_bar(win, true, 'bar2');

  Timer.add(function(info)
    bar1:set_value(bar1.value+5);
    bar2:set_value(bar2.value+5);

    if(bar1.value < 100)
    then
      return Ret.REPEAT;
    else 
      return Ret.REMOVE;
    end
  end, 500);

  win:layout();
end

application_init()


