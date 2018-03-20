DetectHiddenWindows, On

GoToDesktop(n:=1) {
    VIRTUAL_DESKTOP_FOCUS_AFTER_SWITCH=1
    _ChangeDesktop(n)
}

GoToNextDesktop() {
    GoToDesktop(_GetNextDesktopNumber())
}

GoToPrevDesktop() {
    GoToDesktop(_GetPreviousDesktopNumber())
}

MoveToDesktop(n:=1) {
    _MoveCurrentWindowToDesktop(n)
    _Focus()
}

MoveToNextDesktop() {
    MoveToDesktop(_GetNextDesktopNumber())
}

MoveToPrevDesktop() {
    MoveToDesktop(_GetPreviousDesktopNumber())
}

MoveAndGoToDesktop(n:=1) {
    VIRTUAL_DESKTOP_FOCUS_AFTER_SWITCH=1
    MoveToDesktop(n)
    GoToDesktop(n)
}

MoveAndGoToNextDesktop() {
    MoveAndGoToDesktop(_GetNextDesktopNumber())
}

MoveAndGoToPrevDesktop() {
    MoveAndGoToDesktop(_GetPreviousDesktopNumber())
}

_GetNumberOfDesktops() {
    return DllCall(GetDesktopCountProc)
}

_GetCurrentDesktopNumber() {
    return DllCall(GetCurrentDesktopNumberProc) + 1
}

_GetCurrentWindowID() {
    WinGet, activeHwnd, ID, A
    return activeHwnd
}

_GetNextDesktopNumber() {
    i := _GetCurrentDesktopNumber()
	if (VIRTUAL_DESKTOP_WRAP == 1) {
		i := (i == _GetNumberOfDesktops() ? 1 : i + 1)
	} else {
		i := (i == _GetNumberOfDesktops() ? i : i + 1)
	}

    return i
}

_GetPreviousDesktopNumber() {
    i := _GetCurrentDesktopNumber()
	if (VIRTUAL_DESKTOP_WRAP == 1) {
		i := (i == 1 ? _GetNumberOfDesktops() : i - 1)
	} else {
		i := (i == 1 ? i : i - 1)
	}

    return i
}

_ChangeDesktop(n:=1) {
    if (n == 0) {
        n := 10
    }

	; are we there already?
    desktopPos := _GetCurrentDesktopNumber()
	if (desktopPos == n)
		return

    dist := n - desktopPos

	; prefer key-based switch over dll, as it's less likely to flash
    if (dist == 1)
		send ^#{right}
    else if (dist == -1)
		send ^#{left}
    else
        DllCall(GoToDesktopNumberProc, Int, n-1)
}

_MoveCurrentWindowToDesktop(n:=1) {
    activeHwnd := _GetCurrentWindowID()
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, n-1)
}

_GetForemostWindowIdOnDesktop(n) {
    if (n == 0) {
        n := 10
    }
    ; Desktop count starts at 1 for this script, but at 0 for Windows.
    n -= 1

    ; winIDList contains a list of windows IDs ordered from the top to the bottom for each desktop.
    WinGet winIDList, list
    Loop % winIDList {
        windowID := % winIDList%A_Index%
        windowIsOnDesktop := DllCall(IsWindowOnDesktopNumberProc, UInt, WindowID, UInt, n)
        ; Select the first (and foremost) window which is in the specified desktop.
        if (WindowIsOnDesktop == 1) {
            return WindowID
        }
    }
}

; Give focus to the foremost window on the desktop.
_Focus() {
    foremostWindowId := _GetForemostWindowIdOnDesktop(_GetCurrentDesktopNumber())
	;tooltip % "is :" +foremostWindowId
    WinActivate, ahk_id %foremostWindowId%
}

; Only give focus to the foremost window if it has been requested.
_FocusIfRequested() {
    if (VIRTUAL_DESKTOP_FOCUS_AFTER_SWITCH) {
        _Focus()
        VIRTUAL_DESKTOP_FOCUS_AFTER_SWITCH=0
    }
}

; Listeners

OnDesktopSwitch(n:=1) {
    _FocusIfRequested()
}

OnExplorerRestart(wParam, lParam, msg, hwnd) {
    global RestartVirtualDesktopAccessorProc
    DllCall(RestartVirtualDesktopAccessorProc, UInt, result)
}

; Windows 10 desktop changes listener
VWMess(wParam, lParam, msg, hwnd) {
    OnDesktopSwitch(lParam + 1)
}
