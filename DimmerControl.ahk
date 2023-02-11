#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 3

lastWinId = ""
OpenDimmer(){
    global lastWinId
    if WinExist("ahk_exe Dimmer.exe") {
        WinGet, lastWinId ,, A

        WinActivate Dimmer
    } else {
        Run, C:\ProgramExes\DimmerOpen.ahk.exe
    }
}

CloseDimmer(){
    global lastWinId
    WinActivate ahk_id %lastWinId%
}

BrightDown(n){
    Send {Left %n%}
}
BrightUp(n){
    Send {Right %n%}
}


#+D::OpenDimmer()

#IfWinActive Dimmer
!4::BrightDown(1)

!5::BrightUp(1)

~Alt up::CloseDimmer()
#IfWinActive 

