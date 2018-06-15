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

-- top, bottom
hs.hotkey.bind({'cmd', 'ctrl'}, 'i', keyCode('up', {'cmd', 'fn'}), nil, keyCode('up', {'cmd', 'fn'}))
hs.hotkey.bind({'cmd', 'ctrl'}, 'k', keyCode('down', {'cmd', 'fn'}), nil, keyCode('down', {'cmd', 'fn'}))

-- focus
hs.hotkey.bind({'cmd', 'shift'}, 'e', function()
  hs.application.launchOrFocus("Terminal")
end)

-- react native
local timer = require("hs.timer")
local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")
local events = eventtap.event.types --all the event types

timeFrame = 1 --this is the timeframe in which the second press should occur, in seconds
key = 53 --the specific keycode we're detecting, in this case, 50
-- print(keycodes.map["escape"])
--print(keycodes.map["`"]) you can look up the certain keycode by accessing the map

function twoHandler()
    hs.execute('/usr/local/bin/adb shell input text "RR"')
    -- hs.alert("Pressed escape twice!") --the handler for the double press
end

function correctKeyChecker(event) --keypress validator, checks if the keycode matches the key we're trying to detect
    local keyCode = event:getKeyCode()
    return keyCode == key --return if keyCode is key
end

function inTime(time) --checks if the second press was in time
    return timer.secondsSinceEpoch() - time < timeFrame --if the time passed from the first press to the second was less than the timeframe, then it was in time
end

local pressTime, firstDown = 0, false --pressTime was the time the first press occurred which is set to 0, and firstDown indicates if the first press has occurred or not

eventtap.new({ events.keyDown }, function(event) --watch the keyDown event, trigger the function every time there is a keydown
    if correctKeyChecker(event) then --if correct key
        if firstDown and inTime(pressTime) then --if first press already happened and the second was in time
            twoHandler() --execute the handler
        elseif not firstDown or inTime(pressTime) then --if the first press has not happened or the second wasn't in time
            pressTime, firstDown = timer.secondsSinceEpoch(), true --set first press time to now and first press to true
            return false --stop prematurely
        end
    end
    pressTime, firstDown = 0, false --if it reaches here that means the double tap was successful or the key was incorrect, thus reset timer and flag
    return false --keeps the event propogating
end):start() --start our watcher

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
