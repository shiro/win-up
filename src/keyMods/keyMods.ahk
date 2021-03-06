﻿SetCapsLockState, alwaysoff

; esc isn't useful, feel free to put anything here
CapsLock::Esc

; vim like explorer navigation
#IfWinActive ahk_class CabinetWClass

!h::send !{Up}
!l::send {Enter}

#IfWinActive

; vim like arrow keys
; #IfWinNotActive, ahk_group idea
!h::send {Left}
!j::send {Down}
!k::send {Up}
!l::send {Right}

; also with C modifier
!^l::send ^{Right}
!^h::send ^{Left}

; also with CS modifier
!^+l::send ^+{Right}
!^+h::send ^+{Left}
; #IfWinNotActive


; exit the script
#F3::exitApp

; ctrl/esc-modifier key
*Esc::
	if (!ESC_MOD_DOWN){
		ESC_MOD_DOWN := true
		Send {LControl down}
		time_of_last_esc := A_TickCount
	}
	Return

*Esc up::
	ESC_MOD_DOWN := false
	Send {LControl up}
	if (A_PriorKey=="Escape" && (A_TickCount - time_of_last_esc) < 200){
		prefix = 
		if GetKeyState("LCtrl", "P")
			prefix .= "^"
		if GetKeyState("Shift", "P")
			prefix .= "+"
		if GetKeyState("Alt", "P")
			prefix .= "!"
		send % prefix . "{Esc}"
	}
	Return


; prevent triggering tab on press down
Tab::
	TIME_OF_LAST_TAB := A_TickCount
	Return

; fix quick alt-tabbing
~!Tab::
	ALTTAB_MODE := true
	return

; tab-modifier key
Tab up::
	if (A_PriorKey=="Tab" && !ALTTAB_MODE && (A_TickCount - TIME_OF_LAST_TAB) < 200){
		Send {Tab}
	}
	ALTTAB_MODE := false
	Return


; window managemeent
tabModWindow(n){
	if GetKeyState("Esc", "P")
        MoveAndGoToDesktop(n)
	else
		GoToDesktop(n)
	return
}

; modifier + anything
tabModKey(keys){
	send % "^+!" + keys
}


; switch to app
switchToApplication(application){
	IfWinNotActive, %application%
	WinActivate, %application%
}


; virtual desktops
~Tab & h::tabModWindow(1)
~Tab & j::tabModWindow(2)
~Tab & k::tabModWindow(3)
~Tab & l::tabModWindow(4)

~Tab & u::tabModWindow(5)
~Tab & i::tabModWindow(6)
~Tab & o::tabModWindow(7)
~Tab & y::tabModWindow(8)

; adjust system volume
#NumpadAdd::Send {Volume_Up 2}
#NumpadSub::Send {Volume_Down 2}


; navigate virtual desktops with the mouse
#RButton::
	CoordMode, Mouse, Screen ; makes mouse coordinates to be relative to screen.
	MouseGetPos xPos, yPos ; get mouse coordinates

	targetDesktopId := floor(xPos / (A_ScreenWidth / 4)) + 1
	targetDesktopId += (floor(yPos / (A_ScreenHeight / 2)) == 0) ? 0 : 4

	GoToDesktop(targetDesktopId)
	return


; misc keys
Tab & 0::tabModKey("0")
Tab & 1::switchToApplication("Vivaldi")
Tab & 2::
  if (!WinActive("Thunderbird"))
    switchToApplication("Thunderbird")
  else
    WinMinimize
  return
Tab & 3::tabModKey("3")
Tab & 4::tabModKey("4")
Tab & 5::tabModKey("5")
Tab & 6::tabModKey("6")
Tab & 7::tabModKey("7")
Tab & 8::tabModKey("8")
Tab & 9::tabModKey("9")

Tab & '::tabModKey("'")
Tab & ,::tabModKey(",")
Tab & -::tabModKey("-")
Tab & .::tabModKey(".")
Tab & /::tabModKey("/")
Tab & =::tabModKey("=")
Tab & [::tabModKey("[")
Tab & \::tabModKey("\")
Tab & ]::tabModKey("]")
Tab & `;::tabModKey(";")
Tab & a::tabModKey("a")
Tab & b::tabModKey("b")
Tab & c::tabModKey("c")
Tab & d::tabModKey("d")
Tab & e::tabModKey("e")
Tab & f::tabModKey("f")
Tab & g::tabModKey("g")
Tab & m::tabModKey("m")
Tab & p::tabModKey("p")
Tab & n::tabModKey("n")
Tab & q::tabModKey("q")
Tab & r::tabModKey("r")
Tab & s::tabModKey("s")
Tab & t::tabModKey("t")
Tab & v::tabModKey("v")
Tab & w::tabModKey("w")
Tab & x::tabModKey("x")
Tab & z::tabModKey("z")

Tab & f1::tabModKey("{f1}")
Tab & f2::tabModKey("{f2}")
Tab & f3::tabModKey("{f3}")
Tab & f4::tabModKey("{f4}")
Tab & f5::tabModKey("{f5}")
Tab & f6::tabModKey("{f6}")
Tab & f7::tabModKey("{f7}")
Tab & f8::tabModKey("{f8}")
Tab & f9::tabModKey("{f9}")
Tab & f10::tabModKey("{f10}")
Tab & f11::tabModKey("{f11}")
Tab & f12::tabModKey("{f12}")

Tab & Delete::tabModKey("{Delete}")
Tab & Pause::tabModKey("{Pause}")
Tab & Home::tabModKey("{Home}")


; special chars
!a::Send ä
!+a::Send Ä
!e::Send ë
!+e::Send Ë
!u::Send ü
!+u::Send Ü
!o::Send ö
!+o::Send Ö
!b::Send ß
!c::Send č
!+c::Send Č
!s::Send š
!+s::Send Š
!z::Send ž
!+z::Send Ž

; fractions
:?O:;1/2::½
:?O:;1/3::⅓
:?O:;1/4::¼
:?O:;1/5::⅕
:?O:;1/6::⅙
:?O:;1/8::⅛
:?O:;2/3::⅔
:?O:;2/5::⅖
:?O:;3/4::¾
:?O:;3/5::⅗
:?O:;3/8::⅜
:?O:;4/5::⅘
:?O:;5/6::⅚
:?O:;5/8::⅝
:?O:;7/8::⅞

; other symbols
:?O:;2exp::²
:?O:;3exp::³
:?O:;angle::∠
:?O:;copyright::©
:?O:;degree::°
:?O:;dollar::$
:?O:;euro::€
:?O:;lol::笑
:?O:;micro::µ
:?O:;micro::μ
:?O:;neko::猫
:?O:;no::✗
:?O:;pi::π
:?O:;pound::£
:?O:;shiro::白
:?O:;shrug::¯\_(ツ)_/¯
:?O:;star::★
:?O:;sum::∑
:?O:;usagi::兎
:?O:;yen::円
:?O:;yes::✓
