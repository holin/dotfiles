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
hs.hotkey.bind({'ctrl'}, 'h', keyCode('delete'), nil, keyCode('delete'))


-- top, bottom
hs.hotkey.bind({'cmd', 'ctrl'}, 'i', keyCode('up', {'cmd', 'fn'}), nil, keyCode('up', {'cmd', 'fn'}))
hs.hotkey.bind({'cmd', 'ctrl'}, 'k', keyCode('down', {'cmd', 'fn'}), nil, keyCode('down', {'cmd', 'fn'}))

-- focus
hs.hotkey.bind({'cmd', 'shift'}, 'e', function()
  hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({'cmd', 'shift'}, 'g', function()
  hs.application.launchOrFocus("Telegram")
end)
