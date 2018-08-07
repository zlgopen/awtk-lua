function application_init()
  local win = Window.create(NULL, 0, 0, 0, 0);
  local rich_text = RichText.create(win, 0, 0, 0, 0);

  rich_text:set_self_layout_params("center", "middle", "100%", "100%");
  rich_text:set_text('<image name="bricks"/><font color="gold" align_v="bottom" size="24">hello awtk!</font><font color="green" size="20">ProTip! The feed shows you events from people you follow and repositories you watch. nhello world. </font><font color="red" size="20">确定取消中文字符测试。确定。取消。中文字符测试。</font>');

  win:layout();
end

tk_ext_widgets_init()

application_init()


