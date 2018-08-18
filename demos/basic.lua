
function application_init() 
  local win = Window.open("basic");

  win:child("inc_value"):on(EventType.CLICK, function(evt) 
    win:child("bar1"):add_value(10);
    win:child("bar2"):add_value(10);
  end);
  
  win:child("dec_value"):on(EventType.CLICK, function(evt) 
    win:child("bar1"):add_value(-10);
    win:child("bar2"):add_value(-10);
  end);
  
  win:child("close"):on(EventType.CLICK, function(evt) 
    print('bar1 value:' .. win:child("bar1"):get_value());
    print('bar2 value:' .. win:child("bar2"):get_value());
  end);
end

application_init()


