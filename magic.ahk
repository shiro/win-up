;#NoTrayIcon
#Persistent
#SingleInstance Force
#MaxHotkeysPerInterval 1000
#InstallMouseHook

#Include %A_ScriptDir%

; Executable code

#include src
	#include virtual_desktops.ahk
	#include main.ahk
	#include quake_console.ahk
#Include %A_ScriptDir%


; Includes

#include src/lib
	#include virtual_desktops.ahk
	#include key_mods.ahk
	#include window_handle.ahk
	#include quake_console.ahk
#Include %A_ScriptDir%
