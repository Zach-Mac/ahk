Loop, Files, C:\ProgramExes\*, F
{
    OutputDebug, %A_LoopFileLongPath%
	; MsgBox, %A_LoopFileName%
    ; KeyWait, Enter, d
    FileCreateShortcut, %A_LoopFileLongPath%, C:\Users\Talos\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%A_LoopFileName%.lnk
    ; Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ""%A_LoopFileLongPath%"" /out ""C:\ProgramExes\%A_LoopFileName%.exe"" /icon ""C:\Dev\ahk\icons\%A_LoopFileName%.ico""
}
