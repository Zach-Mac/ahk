#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; download clipboard song. open explorer when complete
Run, C:\Program Files\Git\git-bash.exe, C:\Users\Talos\Desktop\Audio
WinWaitActive, ahk_exe mintty.exe
Send, youtube-dl -x %Clipboard% --cookies cookies.txt
KeyWait, Enter, d
Send, explorer . {enter}

; open brave
;If WinExist("ahk_exe brave.exe")
;	WinActivate
;Else
Run, C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe, , max

;Process, Exist, brave.exe
;      If Not ErrorLevel ; errorlevel will = 0 if process doesn't exist
;	     Run, C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe, , max
;      Else
;         WinActivate,% "ahk_pid  " ErrorLevel
;      Return

; open Selenium extension
Send, !+s

Return