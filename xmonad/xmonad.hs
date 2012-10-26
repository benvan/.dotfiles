--
-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--
 
import XMonad
import Data.Monoid
import System.Exit
import Control.Monad

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
{-import XMonad.Hooks.ICCCMFocus-}

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.LayoutCombinators hiding ( (|||) )
import XMonad.Layout.Grid
import Control.OldException(catchDyn,try)
import XMonad.Layout.ComboP
import XMonad.Layout.Column
import XMonad.Layout.Named
import XMonad.Layout.TwoPane
import XMonad.Actions.PhysicalScreens

import XMonad.Actions.UpdatePointer
import XMonad.Actions.GridSelect

import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run (spawnPipe)
import System.IO (hPutStrLn)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 

-- =========== java focus hack, see http://mth.io/posts/xmonad-java-focus/ === --

atom_WM_TAKE_FOCUS ::
  X Atom
atom_WM_TAKE_FOCUS =
  getAtom "WM_TAKE_FOCUS"

takeFocusX ::
  Window
  -> X ()
takeFocusX w =
  withWindowSet . const $ do
    dpy       <- asks display
    wmtakef   <- atom_WM_TAKE_FOCUS
    wmprot    <- atom_WM_PROTOCOLS
    protocols <- io $ getWMProtocols dpy w
    when (wmtakef `elem` protocols) $
      io . allocaXEvent $ \ev -> do
          setEventType ev clientMessage
          setClientMessageEvent ev w wmprot 32 wmtakef currentTime
          sendEvent dpy w False noEventMask ev

takeTopFocus ::
  X ()
takeTopFocus =
  withWindowSet $ maybe (setFocusX =<< asks theRoot) takeFocusX . W.peek

-- =========================================================================== --
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "terminator"
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
-- Width of the window border in pixels.
--
myBorderWidth   = 2
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
numlockMask     = 0
myModMask       = mod3Mask
 
-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------
 
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1:web","2:code","3","4","5","6","7:log","8:life","9:sys"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#cc6677"
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((0, xK_Pause), spawn $ XMonad.terminal conf)
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -nb '#222229' -nf '#777'` && eval \"exec $exe\"")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- launch grid
    , ((modm, xK_g                   ), goToSelected defaultGSConfig)
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((controlMask  .|. mod1Mask, xK_l), spawn "superlock")

    -- media controls
    -- play/pause, mediakey and f5
    , ((0       , 0x1008ff14 ), spawn "sp_control pp")
    , ((modm    , 0xffc2     ), spawn "sp_control pp")

    -- volume control
      -- mediakeys
    , ((0       , 0x1008ff11 ), spawn "sp_control vol +4")
    , ((0       , 0x1008ff13 ), spawn "sp_control vol -4")
    , ((0       , 0x1008ff12 ), spawn "sp_control vol mute")
      -- f6/7/8
    , ((modm    , 0xffc3     ), spawn "sp_control vol -4")
    , ((modm    , 0xffc4     ), spawn "sp_control vol +4")
    , ((modm    , 0xffc5     ), spawn "sp_control vol mute")

    , ((modm    , 0xffc6     ), spawn "sp_control track prev")
    , ((modm    , 0xffc7     ), spawn "sp_control track next")

    , ((0,xK_Print), spawn "sleep 0.2; scrot -s")

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile && xmonad --restart")
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    -- Xinerama switch/move screens 1 and 2
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_bracketleft, xK_bracketright] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++

    [((modm .|. mask, key), f sc)
     | (key, sc) <- zip [xK_bracketleft, xK_bracketright] [0..]
     , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $
           onWorkspace "9:sys" (Tall 1 (3/100) (1/2) *|* Full) $ 
           onWorkspace "7:log" grid $
           onWorkspace "2:code" (Tall 1 (3/100) (15/24) ||| full) $
           standardLayouts
  where
    standardLayouts = tiled ||| full
    -- default tiling algorithm partitions the screen into two panes

    --Layouts
    tiled   = Tall nmaster delta ratio
    full    = noBorders Full
    grid    = Tall 2 (3/100) (1/2) ||| Full
 
    -- The default number of windows in the master pane
    nmaster = 1
 
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    {-, maybeToDefinite (isFullscreen -?> doFullFloat)-}
    , resource  =? "sysConsole"     --> doShift "9:sys"
    , resource  =? "spotify"        --> doShift "8:life"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    {-, (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat-}
    {-, isDialog                      --> \w -> focus w-}
    , fmap not (resource =? "sun-awt-X11-XDialogPeer") --> doF avoidMaster
    ]


avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
     W.Stack t [] (r:rs) ->  W.Stack t [r] rs
     otherwise           -> c

 
------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = spawn "/home/bene/.scripts/spotify/status > /home/bene/.scripts/spotify/statusPipe"
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

xmo h = xmobarPP { ppOutput = hPutStrLn h }
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmPrimary   <- spawnPipe "xmobar -x 1"
  xmSecondary <- spawnPipe "xmobar -x 0 .dotrc/.xmobarrc"
  xmonad $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = do 
                                takeTopFocus >> setWMName "LG3D"
                                dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmPrimary, ppSort    = getSortByXineramaRule }
                                dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmSecondary }
                                dynamicLog >> updatePointer (TowardsCentre 1 1),
        startupHook        = myStartupHook
    }
