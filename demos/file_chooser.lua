function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);
  local chooser = Button.create(win, 0, 0, 0, 0);
  local quit = Button.create(win, 0, 0, 0, 0);

  chooser:set_text("chooser");
  chooser:set_self_layout_params("center", "middle:-50", "50%", "30");
  chooser:on(EventType.CLICK, function(evt) 
    local file_chooser = FileChooser.create();

    file_chooser:set_init_dir("./");

    file_chooser:on(EventType.DONE, function(evt) 
      print("dir:" .. file_chooser:get_dir());
      print("filename:" .. file_chooser:get_filename());
      return Ret.OK;
    end);
    file_chooser:choose_file_for_save();

    return Ret.OK;
  end);

  quit:set_text("quit");
  quit:set_self_layout_params("center", "middle", "50%", "30");
  quit:on(EventType.CLICK, function(evt) 
    Global:quit();
  end);

  win:layout();
end

application_init()


