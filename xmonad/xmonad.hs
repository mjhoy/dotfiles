import XMonad
import XMonad.Util.EZConfig

-- xmonad config!
--
-- things to remember:
-- mod-q => reload xmonad
-- cheatsheet => https://wiki.haskell.org/wikiupload/b/b8/Xmbindings.png

xF86AudioRaiseVolume,xF86AudioLowerVolume, xF86AudioMute :: KeySym
xF86AudioRaiseVolume = 0x1008ff13
xF86AudioLowerVolume = 0x1008ff11
xF86AudioMute = 0x1008ff12

myModMask = mod4Mask

addl = [ ((myModMask, xK_m), spawn "echo 'Hi, mom!' | dzen2 -p 4")

         -- standard audio keys
       , ((0, xF86AudioRaiseVolume), volUp)
       , ((0, xF86AudioLowerVolume), volDn)
       , ((0, xF86AudioMute), spawn "amixer set Master playback 0% -q")

         -- acer laptop: F10/F9 are audio keys
       , ((myModMask, xK_F10), volUp)
       , ((myModMask, xK_F9), volDn)
       ]

volUp = spawn "amixer set Master playback 2.5dB+ -q"
volDn = spawn "amixer set Master playback 2.5dB- -q"

main = xmonad $ defaultConfig { modMask = myModMask
                              , focusedBorderColor = "#000000"
                              , startupHook = startup
                              } `additionalKeys` addl

startup = do
  spawn "dmenu_run"
