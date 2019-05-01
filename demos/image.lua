function on_click(ctx, evt) 
  print('on_click');
end

function create_image(win, image_name, draw_type) 
  local image = Image.create(win, 0, 0, 0, 0);

  image:use_style('border');
  image:set_draw_type(draw_type);
  image:set_image(image_name);

  return image;
end

function application_init()
  local image = nil;
  local win = Window.create(nil, 0, 0, 0, 0);

  image = create_image(win, 'earth', ImageDrawType.ICON);
  image:set_rotation(0.5);
  image:set_scale(1, 2);

  image = create_image(win, 'earth', ImageDrawType.CENTER);
  image = create_image(win, 'earth', ImageDrawType.SCALE_AUTO);
  
  image = create_image(win, '1', ImageDrawType.SCALE);
  image = create_image(win, '2', ImageDrawType.SCALE_W);
  image = create_image(win, '3', ImageDrawType.SCALE_H);
  
  image = create_image(win, 'bricks', ImageDrawType.REPEAT);
  image = create_image(win, 'bricks', ImageDrawType.REPEAT_X);
  image = create_image(win, 'bricks', ImageDrawType.REPEAT_Y);
  
  win.set_children_layout(win, "rows:3 cols:3 margin:2 spacing:2");
  win:layout();
end

application_init()


