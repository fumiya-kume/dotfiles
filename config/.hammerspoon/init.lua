hs.hotkey.bind({"alt"}, "space", function()
  local alacritty = hs.application.find('alacritty')
  if alacritty:isFrontmost() then
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
    -- local win = hs.window.focusedWindow()
    -- local screen = win:screen()
    local screen = hs.screen.primeScreen()
    win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
  end
end)
