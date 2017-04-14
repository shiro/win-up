SendMode Input
;SetTitleMatchMode RegEx

;IfWinActive ahk_class ExploreWClass|CabinetWClass|Progman|WorkerW
;{

;}



; mintty

#c::
    cwd :=  WindowsExplorerLocationByCOM()
    Run % "C:\cygwin\bin\mintty.lnk", %cwd%
    Return

; Vim
#v::
    cwd :=  WindowsExplorerLocationByCOM()
    Run % "C:\cygwin\bin\vim.lnk", %cwd%
    Return

; UAC mintty
#!c::
    cwd :=  WindowsExplorerLocationByCOM()
    Run % "C:\cygwin\bin\minttyUAC.lnk", %cwd%
    Return

; cmd
#.::
    cwd :=  WindowsExplorerLocationByCOM()
    Run % "C:\Windows\System32\cmd.lnk /K ""cd /d " . WindowsExplorerLocationByCOM() . ""
    Return

; UAC cmd
#!.::
    cwd :=  WindowsExplorerLocationByCOM()
    Run % "C:\Windows\System32\cmdUAC.lnk /K ""cd /d " . WindowsExplorerLocationByCOM() . ""
    Return

; sublime
; #z::
;     Run % "C:\Program Files\Sublime Text\sublime_text.exe"
;     Return







WindowsExplorerLocationByCOM(WndH="")
{
   If ( WndH = "" )
      WndH := WinExist("A")
   WinGet Process, ProcessName, ahk_id %WndH%
   If ( Process = "explorer.exe" )
   {
      WinGetClass Class, ahk_id %WndH%
      If ( Class ~= "Progman|WorkerW" )
         Location := A_Desktop
         ;MsgBox % "desktop"
      Else If ( Class ~= "(Cabinet|Explore)WClass" )
      {
         For Window In ComObjCreate("Shell.Application").Windows
            If ( Window.HWnd == WndH )
            {
               URL := Window.LocationURL
               Break
            }
         StringTrimLeft, Location, URL, 8 ; remove "file:///"
         StringReplace Location, Location, /, \, All
         StringReplace Location, Location, `%20, ` , All ;fix spaces
         Location := RTrim(Location,"\\") ; remove trailing slash
      }
   }
   Return Location?Location:A_Desktop
}
