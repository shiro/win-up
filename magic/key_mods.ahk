SetCapsLockState, alwaysoff

; esc isn't useful, feel free to put anything here
CapsLock::Esc

; vim like arrow keys
#IfWinNotActive, ahk_group idea
!h::send {Left}
!j::send {Down}
!k::send {Up}
!l::send {Right}

; also with C modifier
!^l::Send ^{Right}
!^h::Send ^{Left}
#IfWinNotActive


; exit the script
#F3::exitApp

; ctrl/esc-modifier key
*Esc::
	Send {LControl down}
	;time_of_last_esc := A_TickCount
	; msgbox % A_TickCount
	Return


*Esc up::
	Send {LControl up}
	;msgbox % A_PriorKey
	if (A_PriorKey=="Escape"){
		prefix = 
		if GetKeyState("LCtrl", "P")
			prefix .= "^"
		if GetKeyState("Shift", "P")
			prefix .= "+"
		if GetKeyState("Alt", "P")
			prefix .= "!"
		Send(prefix . "{Esc}")
	}
	Return

; prevent triggering tab on press down
Tab::return

; fix quick alt-tabbing
~!Tab::
	ALTTAB_MODE := true
	return

; tab-modifier key
Tab up::
	if (A_PriorKey=="Tab" && !ALTTAB_MODE){
		Send {Tab}
	}
	ALTTAB_MODE := false
	Return

; virtual desktop movement
~Tab & l::
	if GetKeyState("Esc", "P")
		globalDesktopManager._windowMover.moveActiveWindowToNextDesktop(true)
	else
		globalDesktopManager._desktopChanger.goToNextDesktop()
	return
~Tab & h::
	if GetKeyState("Esc", "P")
		globalDesktopManager._windowMover.moveActiveWindowToPreviousDesktop(true)
	else
		globalDesktopManager._desktopChanger.goToPreviousDesktop()
	return
~Tab & i::
	globalDesktopManager._desktopChanger.goToDesktop(TOGGLE_DT_ID)
	TOGGLE_DT_ID := TOGGLE_DT_ID = 1 ? 2 : 1
	return

; modifier + anything
tabModKey(keys){
	Send("^+!" . keys)
}

Tab & '::tabModKey("'")
Tab & ,::tabModKey(",")
Tab & -::tabModKey("-")
Tab & .::tabModKey(".")
Tab & /::tabModKey("/")
Tab & 0::tabModKey("0")
Tab & 1::tabModKey("1")
Tab & 2::tabModKey("2")
Tab & 3::tabModKey("3")
Tab & 4::tabModKey("4")
Tab & 5::tabModKey("5")
Tab & 6::tabModKey("6")
Tab & 7::tabModKey("7")
Tab & 8::tabModKey("8")
Tab & 9::tabModKey("9")
Tab & `;::tabModKey(";")
Tab & =::tabModKey("=")
Tab & [::tabModKey("[")
Tab & \::tabModKey("\")
Tab & ]::tabModKey("]")
Tab & a::tabModKey("a")
Tab & b::tabModKey("b")
Tab & c::tabModKey("c")
Tab & d::tabModKey("d")
Tab & e::tabModKey("e")
Tab & f::tabModKey("f")
Tab & g::tabModKey("g")
Tab & j::tabModKey("j")
Tab & k::tabModKey("k")
Tab & m::tabModKey("m")
Tab & n::tabModKey("n")
Tab & o::tabModKey("o")
Tab & p::tabModKey("p")
Tab & q::tabModKey("q")
Tab & r::tabModKey("r")
Tab & s::tabModKey("s")
Tab & t::tabModKey("t")
Tab & u::tabModKey("u")
Tab & v::tabModKey("v")
Tab & w::tabModKey("w")
Tab & x::tabModKey("x")
Tab & y::tabModKey("y")
Tab & z::tabModKey("z")
