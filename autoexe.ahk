Loop, Files, C:\Dev\ahk\*.ahk, F
{
    OutputDebug, %A_LoopFileLongPath%
	; MsgBox, %A_LoopFileName%
    ; KeyWait, Enter, d
    if FileExist("C:\Dev\ahk\icons\" A_LoopFileName ".ico")
        Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ""%A_LoopFileLongPath%"" /out ""C:\ProgramExes\%A_LoopFileName%.exe"" /icon ""C:\Dev\ahk\icons\%A_LoopFileName%.ico""
    else
        ; MsgBox, %A_LoopFileName% does not have an icon
        Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ""%A_LoopFileLongPath%"" /out ""C:\ProgramExes\%A_LoopFileName%.exe""
}
