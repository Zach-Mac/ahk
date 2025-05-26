; Show Picture-in-Picture window on all desktops and add shortcuts:
; Win+`         - Activate PiP window
; Win+Alt+P     - Activate PiP window
; Win+Capslock  - Pause/Unpause (returns to previous window)
; Win+Ctrl+Up   - Unmute (returns to previous window)
; Win+Ctrl+Dn   - Mute (returns to previous window)
; Win+Alt+F     - Activate PiP + fullscreen + unmute
; Win+Alt+T     - Return to source tab

#SingleInstance force

; FileGetTime ScriptStartModTime, %A_ScriptFullPath%
; SetTimer CheckScriptUpdate, 100, 0x7FFFFFFF ; 100 ms, highest priority
; CheckScriptUpdate() {
;     global ScriptStartModTime
;     FileGetTime curModTime, %A_ScriptFullPath%
;     if (curModTime == ScriptStartModTime)
;         return
;     SetTimer CheckScriptUpdate, Off
;     loop {
;         reload
;         Sleep 300 ; ms
;         MsgBox 0x2, %A_ScriptName%, Reload failed. ; 0x2 = Abort/Retry/Ignore
;         IfMsgBox Abort
;         ExitApp
;         IfMsgBox Ignore
;         break
;     } ; loops reload on "Retry"
; }


DetectHiddenText, On

global PIP_WINDOW := "Picture-in-Picture ahk_class MozillaDialogClass ahk_exe firefox.exe"


SetTimer, ShowWindowOnAllDesktops, 500
Return

ShowWindowOnAllDesktops() {
    global PIP_WINDOW
    if WinExist(PIP_WINDOW) {
        WinGet, exstyle, ExStyle, %WindowTitle%
        if !(exstyle & 0x00000080)
            WinSet, ExStyle, 0x00000080, %WindowTitle%
    }
}


ActivatePictureInPicture() {
    WinActivate, %PIP_WINDOW%
    WinWaitActive, %PIP_WINDOW%
}


#!p:: ; Activate Picture-in-Picture window
#`:: ; Activate Picture-in-Picture window
{
    ActivatePictureInPicture()
    return
}


#Capslock:: ; Activate PiP and pause
{
    WinGet, previousWindow, ID, A  ; Store current active window
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        Send, {Space}
        WinActivate, ahk_id %previousWindow%  ; Restore previous window
    }
    return
}

#!f:: ; Activate Picture-in-Picture window, fullscreen and unmute
{
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        Send, f
        Send, ^{Up}
    }
    return
}

ReturnToTab() {
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        MouseGetPos, oldX, oldY  ; Store current mouse position
        Click, 29, 30  ; Click the return to tab button
        Sleep, 100  ; Wait for click to complete
        MouseMove, %oldX%, %oldY%  ; Restore mouse position
    }
}
#!t:: ; Return to source tab
{
    ReturnToTab()
    return
}

#^Up:: ; Unmute
{
    WinGet, previousWindow, ID, A  ; Store current active window
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        Send, ^{Up}
        WinActivate, ahk_id %previousWindow%  ; Restore previous window
    }
    return
}

#^Down:: ; Mute
{
    WinGet, previousWindow, ID, A  ; Store current active window
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        Send, ^{Down}
        WinActivate, ahk_id %previousWindow%  ; Restore previous window
    }
    return
}

; try 
;     {
;         if ImageSearch, FoundX, FoundY, centerWindowX, centerWindowY, centerWindowX+rightClickMenuSize, centerWindowY+rightClickMenuSize, *50 showThisWindowOnAllDesktopsWindows10.png
;             MsgBox % "The icon was found at " FoundX "x" FoundY
;         else
;             MsgBox % "Icon could not be found on the screen."
;     }
;     catch exc
;         MsgBox % "Could not conduct the search due to the following error:`n" exc.Message


