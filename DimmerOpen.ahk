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

Click, 154 230

WinActivate ahk_id %winid%

SetMouseDelay, -1
MouseMove, StartX, StartY
