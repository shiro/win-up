﻿SetCapsLockState, alwaysoff

; esc isn't useful, feel free to put anything here
CapsLock::Esc

; vim like explorer navigation
#IfWinActive ahk_class CabinetWClass

!h::send !{Up}
!l::send {Enter}

#IfWinActive

; vim like arrow keys
#IfWinNotActive, ahk_group idea
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
#IfWinNotActive


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


; virtual desktops
~Tab & h::tabModWindow(1)
~Tab & j::tabModWindow(2)
~Tab & k::tabModWindow(3)
~Tab & l::tabModWindow(4)

~Tab & u::tabModWindow(5)
~Tab & i::tabModWindow(6)
~Tab & o::tabModWindow(7)
~Tab & y::tabModWindow(8)

; misc keys
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
:?O:;copyright::©
:?O:;degree::°
:?O:;euro::€
:?O:;lol::笑
:?O:;micro::µ
:?O:;neko::猫
:?O:;pound::£
:?O:;shiro::白
:?O:;usagi::兎
:?O:;shrug::¯\_(ツ)_/¯

