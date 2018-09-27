;#NoTrayIcon
#Persistent
#SingleInstance Force
#MaxHotkeysPerInterval 1000
#InstallMouseHook

#Include %A_ScriptDir%


; init
#include src
	#include main.ahk
  #include virtualDesktops/init.ahk
	#include quakeConsole/init.ahk
#Include %A_ScriptDir%



; functions
#include src
  #include virtualDesktops/virtualDesktops.ahk
	#include keyMods/keyMods.ahk
	#include windowHandling/windowHandling.ahk
	#include quakeConsole/quakeConsole.ahk
#Include %A_ScriptDir%
