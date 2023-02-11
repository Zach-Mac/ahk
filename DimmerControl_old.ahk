#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

lastWinId = ""

OpenDimmer()
{
    global lastWinId
    if WinExist("ahk_exe Dimmer.exe") {
        WinGet, lastWinId ,, A

        WinShow, Dimmer
        WinActivate, Dimmer
    } else {
        Run, C:\ProgramExes\DimmerOpen.ahk.exe
    }
}

CloseDimmer()
{
    global lastWinId
    ; WinHide, Dimmer
    WinActivate ahk_id %lastWinId%
}

BrightDown(n){
    Send {Left %n%}
}
BrightUp(n){
    Send {Right %n%}
}

Down10:
    BrightDown(10)
    return
Down1:
    BrightDown(1)    
    return
Up1:
    BrightUp(1)
    return
Up10:
    BrightUp(10)
    return

SetOpen(){
    Hotkey, !3, Open3
    Hotkey, !4, Open4
    Hotkey, !5, Open5
    Hotkey, !6, Open6
}
SetOpen()

SetUpDown(){
    Hotkey, !3, Down10
    Hotkey, !4, Down1
    Hotkey, !5, Up1
    Hotkey, !6, Up10
}

Open3:
!3::
    OpenDimmer()
    SetUpDown()
    ; BrightDown(10)
    return

Open4:
!4::
    OpenDimmer()
    SetUpDown()
    ; BrightDown(1)
    return

Open5:
!5::
    OpenDimmer()
    SetUpDown()
    ; BrightUp(1)
    return

Open6:
!6::
    OpenDimmer()
    SetUpDown()
    ; BrightUp(10)
    return

#IfWinActive Dimmer
~Alt up::
    CloseDimmer()
    SetOpen()
    return