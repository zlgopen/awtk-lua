function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local bar = ProgressBar.create(win, 0, 0, 0, 0);

  bar:on(EventType.VALUE_CHANGED, function(evt) 
    print('value changed:');
    return Ret.OK;
  end);

  bar:set_value(50);
  bar:set_show_text(true);
  bar:set_self_layout_params("center", "middle", "90%", "30");
  
  win:layout();
end

application_init()


