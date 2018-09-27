DetectHiddenWindows On

InitQuakeConsole() {
    global

    ; save last active window
    WinGet, hw_current, ID, A

    if !WinExist(ahk_title "quake console") {
        hw_mintty := 0

		ShellRun(minttyPath, minttyArgs)

        WinWait quake console, , 5
        if ErrorLevel {
			tooltip "[WinUp] couldn't find quake console instance", 5
			sleep 5000
			tooltip
			return
        }
    }

	WinGet, hw_mintty, ID, quake console

	ShowQuakeConsole()
    SetAlwaysOnTop()

	HideQuakeConsole()

	; hide window borders and caption/title
	if (!windowBorders)
		WinSet, Style, -0xC40000, ahk_id %hw_mintty%
}

ShowQuakeConsole() {
	global

	; adjust position (multi monitor support)
	VirtScreenPos(screenLeft, screenTop, screenWidth, screenHeight)
	WinMove, ahk_id %hw_mintty%, , %screenLeft%, %screenTop%, %screenWidth%, %heightConsoleWindow%

	WinActivate ahk_id %hw_mintty%

	WinSet, Transparent, %quake_trans%, ahk_id %hw_mintty%
	WinShow, ahk_id %hw_mintty%

	if (quake_autohide)
		SetTimer, HideWhenInactive, 250
}

HideQuakeConsole() {
	global

	WinHide, ahk_id %hw_mintty%

	if (quake_autohide)
	SetTimer, HideWhenInactive, Off
}

ToggleQuakeConsole() {
    global

    if(winActive("ahk_id " . hw_mintty)) {
		HideQuakeConsole()

		WinActivate, ahk_id %hw_current%
    } else {
		WinGet, hw_current, ID, A

		ShowQuakeConsole()
    }
}


HideWhenInactive() {
	global
    if(!WinActive("ahk_id " . hw_mintty)) {
		HideQuakeConsole()
        SetTimer, HideWhenInactive, Off
    }
}


!d::
	if(WinExist("ahk_id " . hw_mintty)) {
		ToggleQuakeConsole()
	} else {
		InitQuakeConsole()
	}
return




; todo export lib

SetAlwaysOnTop() {
    global alwaysOnTop
    if (alwaysOnTop)
        Winset, AlwaysOnTop, On
    else
        Winset, AlwaysOnTop, Off
}



VirtScreenPos(ByRef mLeft, ByRef mTop, ByRef mWidth, ByRef mHeight) {
    global displayOnMonitor
    if (displayOnMonitor > 0) {
        SysGet, Mon, Monitor, %displayOnMonitor%
        SysGet, MonArea, MonitorWorkArea, %displayOnMonitor%

        mLeft:=MonAreaLeft
        mTop:=MonAreaTop
        mWidth:=(MonAreaRight - MonAreaLeft)
        mHeight:=(MonAreaBottom - MonAreaTop)
    } else {
        Coordmode, Mouse, Screen
        MouseGetPos, x, y
        SysGet, m, MonitorCount

        ; Iterate through all monitors.
        Loop, %m%
        {   ; Check if the mouse is on this monitor.
            SysGet, Mon, Monitor, %A_Index%
            SysGet, MonArea, MonitorWorkArea, %A_Index%
            if (x >= MonLeft && x <= MonRight && y >= MonTop && y <= MonBottom) {
                mLeft:=MonAreaLeft
                mTop:=MonAreaTop
                mWidth:=(MonAreaRight - MonAreaLeft)
                mHeight:=(MonAreaBottom - MonAreaTop)
            }
        }
    }
}



ExpandEnvVars(ppath) {
	VarSetCapacity(dest, 2000)
	DllCall("ExpandEnvironmentStrings", "str", ppath, "str", dest, int, 1999, "Cdecl int")
	return dest
}




; run as a normal user even if we are elevated

ShellRun(Prg, Args := "", wDir := "") {
	static (StartupInfo, VarSetCapacity(StartupInfo, 6 * A_PtrSize + 44), NumPut(6 * A_PtrSize + 44, StartupInfo), VarSetCapacity(ProcessInfo, 16)), ShellToken := GetShellToken()
	If A_IsAdmin {
		DllCall("Advapi32\CreateProcessWithTokenW", "Ptr", ShellToken, "Int", 0, "Ptr", 0, "WStr", """" Prg """ " Args, "Int", 0, "Ptr", 0, wDir == "" ? "Ptr" : "WStr", wDir == "" ? 0 : wDir, "Str", StartupInfo, "Str", ProcessInfo)
		 return NumGet(ProcessInfo, A_PtrSize << 1, "UInt"), DllCall("CloseHandle", "Ptr", NumGet(ProcessInfo)), DllCall("CloseHandle", "Ptr", NumGet(ProcessInfo, A_PtrSize))
	} Run "%Prg%" %Args%, %wDir%, UseErrorLevel, PID
	   return PID
}

GetShellToken() {
	static Token
	If Token
		return Token
	DllCall("GetWindowThreadProcessId", "Ptr", DllCall("GetShellWindow"), "UInt*", PID)
      , Process := DllCall("OpenProcess", "UInt", 0x400, "Int", false, "UInt", PID, "Ptr")
      , DllCall("Advapi32\OpenProcessToken", "Ptr", Process, "Int", 2, "Ptr*", ShellToken)
      , DllCall("Advapi32\DuplicateTokenEx", "Ptr", ShellToken, "Int", 395, "Ptr", 0, "Int", 2, "Int", 1, "Ptr*", Token)
	 return Token, DllCall("CloseHandle", "Ptr", Process), DllCall("CloseHandle", "Ptr", ShellToken), OnExit(Func("CloseShellToken").Bind(Token))
}

CloseShellToken(Token) {
	DllCall("CloseHandle", "Ptr", Token)
}

