-- mostly copied from
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen%27s_Configuration

import XMonad

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace

import XMonad.Util.EZConfig
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

import System.IO

myLayout = smartBorders Full ||| tiled
    where tiled = Tall 1 (5/100) (1/2)

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/jrutherford/.xmobarrc"
    xmonad $ ewmh defaultConfig
        { layoutHook = avoidStruts $ myLayout
        , manageHook = manageDocks <+> manageHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask -- Rebind mod to super
        , terminal = "terminator -e 'tmux new-session -A -s scratch'"
        , borderWidth = 2
        }
        `additionalKeys`
        [ ((mod4Mask, xK_b), sendMessage ToggleStruts)
        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask, xK_x), spawn "xmodmap /home/jrutherford/.Xmodmap")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
