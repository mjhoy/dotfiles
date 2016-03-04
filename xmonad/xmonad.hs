import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import System.IO (hPutStrLn)

-- xmonad config!
--
-- things to remember:
-- mod-q => reload xmonad
-- cheatsheet => https://wiki.haskell.org/wikiupload/b/b8/Xmbindings.png

xF86AudioRaiseVolume,xF86AudioLowerVolume, xF86AudioMute :: KeySym
xF86AudioRaiseVolume = 0x1008ff13
xF86AudioLowerVolume = 0x1008ff11
xF86AudioMute = 0x1008ff12

-- use Windows/Command key as the modifier key
myModMask = mod4Mask

addl = [ ((myModMask, xK_m), spawn "echo 'Hi, mom!' | dzen2 -p 4")

         -- standard audio keys
       , ((0, xF86AudioRaiseVolume), volUp)
       , ((0, xF86AudioLowerVolume), volDn)
       , ((0, xF86AudioMute), volMt)

         -- acer laptop: F10/9/8 are audio keys
       , ((myModMask, xK_F10), volUp)
       , ((myModMask, xK_F9),  volDn)
       , ((myModMask, xK_F8),  volMt)

         -- F7/6 are brightness keys
         -- doesn't work at the moment, seems to require root?
       , ((myModMask, xK_F7), brightUp)
       , ((myModMask, xK_F6), brightDn)
       ]

volUp = spawn "amixer set Master playback 2.5dB+ -q"
volDn = spawn "amixer set Master playback 2.5dB- -q"
volMt = spawn "amixer set Master playback 0% -q"

brightUp = spawn "light -A 5"
brightDn = spawn "light -U 5"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig { modMask = myModMask
                         , focusedBorderColor = "#000000"
                         , layoutHook = avoidStruts $ layoutHook defaultConfig
                         , manageHook = manageDocks <+> manageHook defaultConfig
                         , logHook = dynamicLogWithPP xmobarPP { ppOutput = hPutStrLn xmproc
                                                               , ppTitle  = xmobarColor "green" "" . shorten 50
                                                               }
                         , startupHook = startup
                         } `additionalKeys` addl

startup = do
  spawn "dmenu_run"
