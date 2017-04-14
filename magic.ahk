;#NoTrayIcon
#Persistent
#NoEnv
#SingleInstance, Force
#MaxHotkeysPerInterval 1000
#InstallMouseHook


; Executable code

#include magic
	#include execution.ahk
#Include %A_ScriptDir%


; Includes

#include windows10DesktopManager
	#Include desktopManager.ahk
	#Include desktopChanger.ahk
	#Include windowMover.ahk
	#Include desktopMapper.ahk
	#include virtualDesktopManager.ahk
	#Include monitorMapper.ahk
	#Include hotkeyManager.ahk
	#Include commonFunctions.ahk
#Include %A_ScriptDir%

#include magic
	#include key_mods.ahk
	#include window_handle.ahk
	;#include cmdHere.ahk
	#include chrome.ahk
#Include %A_ScriptDir%

