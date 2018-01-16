local function keyCode(key, modifiers)
  modifiers = modifiers or {}

  return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

hs.hotkey.bind({'ctrl'}, 'j', keyCode('left'), nil, keyCode('left'))
hs.hotkey.bind({'ctrl'}, 'k', keyCode('down'), nil, keyCode('down'))
hs.hotkey.bind({'ctrl'}, 'i', keyCode('up'), nil, keyCode('up'))
hs.hotkey.bind({'ctrl'}, 'l', keyCode('right'), nil, keyCode('right'))
hs.hotkey.bind({'ctrl'}, 'd', keyCode('forwarddelete'), nil, keyCode('forwarddelete'))

-- pageup, pagedown
hs.hotkey.bind({'cmd', 'ctrl'}, 'i', keyCode('up', {'cmd', 'fn'}), nil, keyCode('up', {'cmd', 'fn'}))
hs.hotkey.bind({'cmd', 'ctrl'}, 'k', keyCode('down', {'cmd', 'fn'}), nil, keyCode('down', {'cmd', 'fn'}))

-- focus
hs.hotkey.bind({'cmd', 'shift'}, 'e', function()
  hs.application.launchOrFocus("Terminal")
end)

-- local ticktrack = {}

-- local webview = nil

-- function ticktrack.toggle()
--   if webview == nil then
--     rect = hs.screen.primaryScreen():frame()
--     rect.x = rect.w - 370
--     rect.w = 570
--     webview = hs.webview.new(rect)
--     webview:url("http://m.baidu.com")
--     webview:allowTextEntry(true)
--     webview:windowStyle({"titled", "closable", "resizable"}) --, "fullSizeContentView"})
--   end

--   win = webview:asHSWindow()
--   if win and win:application():isFrontmost() then
--     webview:hide()
--   else
--     webview:show()
--     hs.application.get("Hammerspoon"):activate()
--   end
-- end
-- ticktrack.toggle()
