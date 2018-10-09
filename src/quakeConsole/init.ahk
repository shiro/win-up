minttyPath := "C:\etc\term\open-wsl.exe"
minttyArgs := "-t ""quake console"" -b ""-e TMUX_ID=2 -e ATTACH=1"""

alwaysOnTop := 1
quake_autohide := 1
windowBorders := 0
displayOnMonitor := 0
minttyPath := ExpandEnvVars(minttyPath)
minttyArgs := ExpandEnvVars(minttyArgs)


heightConsoleWindow := 500 ; px

quake_trans := 240 ; 0-255


initQuakeConsole()
