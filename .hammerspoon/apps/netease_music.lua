-- NeteaseMusic
nextSong = hs.hotkey.bind({}, 'right', function()
  hs.application.launchOrFocus("NeteaseMusic")
  nextSong:disable() -- does not work without this, even though it should
  hs.eventtap.keyStroke({'cmd'}, 'right')
  hs.timer.usleep(1000)
  nextSong:enable()
end, nil, nil)
