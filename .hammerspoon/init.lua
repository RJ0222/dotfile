hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

-- hs.loadSpoon("SpeedMenu")
hs.loadSpoon("WinWin")

function fcenter()
    local win = hs.window.focusedWindow()
    if win then
        local screen = win:screen()
        local max = screen:fullFrame()
        local stepw = max.w/40
        local steph = max.h/40
        win:setFrame({x = stepw*8, y = steph*6, w = stepw*24, h = steph*28})
    else
        hs.alert.show("No focused window!")
    end
end

-- basic split
hs.hotkey.bind({"cmd", "alt"}, "left", "Lefthalf of Screen", function() spoon.WinWin:moveAndResize('halfleft') end)
hs.hotkey.bind({"cmd", "alt"}, "right", "Righthalf of Screen", function() spoon.WinWin:moveAndResize('halfright') end)
hs.hotkey.bind({"cmd", "alt"}, "up", "Fullscreen", function() spoon.WinWin:moveAndResize('fullscreen') end)
hs.hotkey.bind({"cmd", "alt"}, "down", "Resize & Center", function() fcenter() end)

-- advanced split hotkey
hyper = {"ctrl", "cmd", "option"}

-- left top split
hs.hotkey.bind(hyper, "left", function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)

-- left button split
hs.hotkey.bind(hyper, "right", function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + max.h/2
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)


-- right top split
hs.hotkey.bind(hyper, "up", function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + max.w/2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)


-- right down split
hs.hotkey.bind(hyper, "down", function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + max.w/2
    f.y = max.y + max.h/2
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)

-- mutil window moving
local hyper2 = {'ctrl', 'cmd'}

hs.hotkey.bind(hyper2, 'left', function()
    local w = hs.window.focusedWindow()
    if not w then
        return
    end
    local s = w:screen():toWest()
    if s then
        w:moveToScreen(s)
        spoon.WinWin:moveAndResize('fullscreen')
    end
end)

hs.hotkey.bind(hyper2, 'right', function()
    local w = hs.window.focusedWindow()
    if not w then
        return
    end
    local s = w:screen():toEast()
    if s then
        w:moveToScreen(s)
        spoon.WinWin:moveAndResize('fullscreen')
    end
end)
