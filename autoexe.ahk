Loop, Files, C:\Dev\ahk\*.ahk, F
{
    OutputDebug, %A_LoopFileLongPath%
	; MsgBox, %A_LoopFileName%
    ; KeyWait, Enter, d
    Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ""%A_LoopFileLongPath%"" /out ""C:\ProgramExes\%A_LoopFileName%.exe"" /icon ""C:\Dev\ahk\icons\%A_LoopFileName%.ico""
; [/out MyScript.exe] [/icon MyIcon.ico]
}

; d := StrReplace(A_Desktop, "Desktop", "Downloads\*.txt")
; Loop, Files, % d
;     MsgBox, %A_LoopFileName%