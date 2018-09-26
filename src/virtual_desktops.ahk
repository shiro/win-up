SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On

hwnd:=WinExist("ahk_pid " . DllCall("GetCurrentProcessId","Uint"))
hwnd+=0x1000<<32

virtualDesktopAccessorPath := A_ScriptDir "\src\lib\VirtualDesktopAccessor.dll"


hVirtualDesktopAccessor := DllCall("LoadLibrary", Str, virtualDesktopAccessorPath, "Ptr")

if (!hVirtualDesktopAccessor){
    msgbox % "ERROR: Failed to load library: " virtualDesktopAccessorPath " (err: " A_LastError ")"
    exitApp
}

global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")
global RegisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "RegisterPostMessageHook", "Ptr")
global UnregisterPostMessageHookProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnregisterPostMessageHook", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")
global GetDesktopCountProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetDesktopCount", "Ptr")
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnDesktopNumber", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
global IsPinnedWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedWindow", "Ptr")
global PinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinWindow", "Ptr")
global UnPinWindowProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinWindow", "Ptr")
global IsPinnedAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsPinnedApp", "Ptr")
global PinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "PinApp", "Ptr")
global UnPinAppProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "UnPinApp", "Ptr")


global VIRTUAL_DESKTOP_FOCUS_AFTER_SWITCH := 1
global VIRTUAL_DESKTOP_WRAP := 1
global VIRTUAL_DESKTOP_TOKEN := 0 ; prevent focusing wrong window if switching quickly


; Restart the virtual desktop accessor when Explorer.exe crashes, or restarts (e.g. when coming from fullscreen game)
explorerRestartMsg := DllCall("user32\RegisterWindowMessage", "Str", "TaskbarCreated")
OnMessage(explorerRestartMsg, "OnExplorerRestart")


; Windows 10 desktop changes listener
DllCall(RegisterPostMessageHookProc, Int, hwnd, Int, 0x1400 + 30)
OnMessage(0x1400 + 30, "VWMess")

; remember current desktop number
currentDesktopPos := _GetCurrentDesktopNumber()

; make sure there are 10 desktops
nrOfDesktopsNeeded := 8 -_GetNumberOfDesktops()
Send #^{d %nrOfDesktopsNeeded%}

; jump back to inital desktop
GoToDesktop(currentDesktopPos)

