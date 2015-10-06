import XMonad
import XMonad.Util.EZConfig

myModMask = mod4Mask

main = xmonad $ defaultConfig {
                  modMask = myModMask
                , focusedBorderColor = "#000000"
                , startupHook = startup
                }
                `additionalKeys`
                [ ((myModMask, xK_m), spawn "echo 'Hi, mom!' | dzen2 -p 4")
                ]

startup = do
  spawn "dmenu_run"