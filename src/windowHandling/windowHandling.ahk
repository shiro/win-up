#q::
	Send !{f4}
	return


; F4::
; WinShow,ahk_class Shell_TrayWnd 
; return
; 
; F5::
; WinHide,ahk_class Shell_TrayWnd 
; return


; ;minimize window
; #y::
; 	WinMinimize, A
; 	return

; ;maximize window
; #x::
; 	Send #{Up}
; 	return

; ;make window smaller / minimize
; #c::
; 	Send #{Down}
; 	return

; ; Show Desktop
; ~#d::
; 	;WinMinimizeAll
; 	showDesktopFix()
; 	return

; Taskbar actions
~LButton::
	MouseGetPos, x, y, win
	WinGetClass, Class, ahk_id %win%

	if ( Class != "Shell_TrayWnd" )
		return

	if (x > 1912) ; Peek to desktop button
		showDesktopFix()
		
	else if (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500){ ; Double click empty space, minimize all
		;if(x > 1000)
			;WinMinimizeAll
		;else
		;	WinMinimizeAll
	}
	return

; Minimize all
^!Numpad9::WinMinimizeAll

; Minimize all but active
!Numpad9::WinMinimizeAllButActive()


; Close all of active
#^q::
	WinGetClass class, A
	GroupAdd tmp, ahk_class %class%
	WinClose ahk_group tmp
	return


; Fix foobar2000 media search
~NumpadSub::
	WinWaitActive, Playlist Search,, 0.07
	if ErrorLevel
		WinActivate, Playlist Search

	while WinActive("Playlist Search"){
		KeyWait, Down, D, T.1
		if !ErrorLevel{
			Send, {tab}{tab}{Down}{Down}
			break
		}
	}
	return




showDesktopFix(){
	WinWaitActive, ahk_class WorkerW
	Gui, Add, Text
	Gui, Show, x0 y0 w0 h0
	Gui, Destroy

	winActivate, ahk_class Progman
	return
}



WinMinimizeAllButActive(){
	WinGet,id,ID,A
	WinGet,style,Style,ahk_id %id%
	If(style & 0x20000)
	{
		WinGet,winid_,List,,,Program Manager
		Loop,%winid_% 
		{
			StringTrimRight,winid,winid_%A_Index%,0
			If id=%winid%
				Continue
			WinGet,style,Style,ahk_id %winid%
			If(style & 0x20000)
			{
				WinGet,state,MinMax,ahk_id %winid%,
				If state=-1
					Continue
				WinGetClass,class,ahk_id %winid%
				If class=Shell_TrayWnd
					Continue
				IfWinExist,ahk_id %winid%
				WinMinimize,ahk_id %winid%
			}
		}
	}
}


;~WheelDown::
;MouseGetPos,,,,Control,1
;If (Control = "MSTaskListWClass1") ; Taskbar control
;{
;	WinGetClass, CurrentActive, A
;	WinGet, Instances, Count, ahk_class %CurrentActive%
;	If Instances > 1
;		WinActivateBottom, ahk_class %CurrentActive%
;
;	}
;return
