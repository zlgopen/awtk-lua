function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local ok = Button.create(win, 0, 0, 0, 0);

  ok:set_text("ok");
  ok:set_self_layout_params("center", "middle", "50%", "30");
  ok:on(EventType.CLICK, function(evt) 
    local e = PointerEvent.cast(evt);
    print("on click:" .. tostring(e.x) .. " " .. tostring(e.y))

    return Ret.OK;
  end);

  win:layout();
end

application_init()


