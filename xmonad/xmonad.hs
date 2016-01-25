import XMonad
import XMonad.Util.EZConfig

xF86AudioRaiseVolume,xF86AudioLowerVolume, xF86AudioMute :: KeySym
xF86AudioRaiseVolume = 0x1008ff13
xF86AudioLowerVolume = 0x1008ff11
xF86AudioMute = 0x1008ff12

myModMask = mod4Mask

addl = [ ((myModMask, xK_m), spawn "echo 'Hi, mom!' | dzen2 -p 4")
       , ((0, xF86AudioLowerVolume), spawn "amixer set Master playback 2.5dB- -q")
       , ((0, xF86AudioRaiseVolume), spawn "amixer set Master playback 2.5dB+ -q")
       , ((0, xF86AudioMute), spawn "amixer set Master playback 0% -q")
       ]

main = xmonad $ defaultConfig { modMask = myModMask
                              , focusedBorderColor = "#000000"
                              , startupHook = startup
                              } `additionalKeys` addl

startup = do
  spawn "dmenu_run"
