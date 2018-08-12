function create_tab_button(tab_button_group, text)
  local tab_button = TabButton.create(tab_button_group, 0, 0, 0, 0);
  tab_button:set_text(text);

  return tab_button;
end

function create_page(pages, text) 
  local view = View.create(pages, 0, 0, 0, 0);
  view:set_self_layout_params('0', '0', '100%', '100%');

  local label = Label.create(view, 0, 0, 0, 0);
  label:set_self_layout_params('0', 'middle', '100%', '30');
  label:set_text(text);

  return view;
end

function application_init()
  local win = Window.create(nil, 0, 0, 0, 0);
  local tab_button_group = TabButtonGroup.create(win, 0, 0, 0, 0);

  win:set_prop_str(WidgetProp.THEME, 'tab_top_compact');

  tab_button_group:set_prop_str(WidgetProp.COMPACT, 'true');
  tab_button_group:set_self_layout_params('center', '12', '90%', '30');

  create_tab_button(tab_button_group, 'General');
  create_tab_button(tab_button_group, 'Network');
  create_tab_button(tab_button_group, 'Security');

  local  pages = Pages.create(win, 0, 0, 0, 0);
  pages:set_self_layout_params('center', '42', '90%', '-60');

  create_page(pages, 'General');
  create_page(pages, 'Network');
  create_page(pages, 'Security');

  win:layout();
end

application_init()


