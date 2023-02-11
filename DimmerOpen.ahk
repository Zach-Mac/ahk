#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

SetMouseDelay, -1
SetDefaultMouseSpeed, 0

WinGet, winid ,, A
MouseGetPos, StartX, StartY

Run, C:\ProgramExes\Dimmer.exe

WinWaitActive, Dimmer

WinGet, exstyle, ExStyle
If  !(exstyle & 0x00000080)        ; visible on all desktops
    WinSet, exstyle, 0x00000080

Click, 154 230

Click, 63 230

WinActivate ahk_id %winid%

SetMouseDelay, -1
MouseMove, StartX, StartY
