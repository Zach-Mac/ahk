; WinGetClass, class, ahk_exe Dimmer.exe
; MsgBox, The active window's class is "%class%".

; DetectHiddenWindows, On
; Winshow, ahk_class HwndWrapper[Dimmer.exe;;b118472f-6459-41e1-9e57-0f7c89b9dd9b]
; Winactivate, ahk_class HwndWrapper[Dimmer.exe;;b118472f-6459-41e1-9e57-0f7c89b9dd9b]
; WinShow, ahk_exe Dimmer.exe
; WinActivate, ahk_exe Dimmer.exe

; WinActivate, Dimmer
SetMouseDelay, -1
SetDefaultMouseSpeed, 0

DimmerClick(position, n)
{
    WinGet, winid ,, A
    MouseGetPos, StartX, StartY

    WinShow, Dimmer
    WinActivate, Dimmer
    
    SetMouseDelay, %n%
    Click, 63 %position% %n%

    ; WinHide, Dimmer
    WinActivate ahk_id %winid%

    SetMouseDelay, -1
    MouseMove, StartX, StartY
}

ChangeBrightness(b, n)
{
    if (b = "INC"){
        position := 234
    }
    if (b = "DEC"){
        position := 123
    } 
    if WinExist("ahk_exe Dimmer.exe") {
        DimmerClick(position, n)
    ;  1680 828 937
        ; 63, 134, 234
    } else {
        Run, Dimmer.exe
    }
}

!3::
ChangeBrightness("DEC",10)
Return

!4::
ChangeBrightness("DEC",1)
Return

!5::
ChangeBrightness("INC",1)
Return

!6::
ChangeBrightness("INC",10)
Return

