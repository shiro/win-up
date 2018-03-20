;#NoTrayIcon
#Persistent
#NoEnv
#SingleInstance, Force
#MaxHotkeysPerInterval 1000
#InstallMouseHook


; Executable code

#include magic
	#include virtual_desktops.ahk
	#include execution.ahk
#Include %A_ScriptDir%


; Includes

#include lib
	#include virtual_desktops.ahk
	#include key_mods.ahk
	#include window_handle.ahk
	;#include cmdHere.ahk
	#include chrome.ahk
#Include %A_ScriptDir%

