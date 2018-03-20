SetCapsLockState, alwaysoff

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

; virtual desktop movement
~Tab & l::
	if GetKeyState("Esc", "P")
        MoveAndGoToNextDesktop()
	else
        GoToNextDesktop()
	return

~Tab & h::
	if GetKeyState("Esc", "P")
        MoveAndGoToPrevDesktop()
	else
        GoToPrevDesktop()
	return


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

Tab & 0::tabModWindow(10)
Tab & 1::tabModWindow(1)
Tab & 2::tabModWindow(2)
Tab & 3::tabModWindow(3)
Tab & 4::tabModWindow(4)
Tab & 5::tabModWindow(5)
Tab & 6::tabModWindow(6)
Tab & 7::tabModWindow(7)
Tab & 8::tabModWindow(8)
Tab & 9::tabModWindow(9)
Tab & '::tabModKey("'")
Tab & ,::tabModKey(",")
Tab & -::tabModKey("-")
Tab & .::tabModKey(".")
Tab & /::tabModKey("/")
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
~Tab & i::tabModKey("i")
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

