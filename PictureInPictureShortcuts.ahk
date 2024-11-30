; Shortcuts:
; Win+Alt+P   - Activate PiP window
; Win+Alt+F   - Activate PiP + fullscreen + unmute
; Win+Alt+T   - Return to source tab
; Win+Ctrl+A  - Show currently active window on all desktops
; Win+Ctrl+Up - Unmute (returns to previous window)
; Win+Ctrl+Dn - Mute (returns to previous window)

#SingleInstance force

global PIP_WINDOW := "Picture-in-Picture ahk_class MozillaDialogClass ahk_exe firefox.exe"

ActivatePictureInPicture() {
    WinActivate, %PIP_WINDOW%
    WinWaitActive, %PIP_WINDOW%
}
#!p:: ; Windows+Alt+P to activate Picture-in-Picture window
{
    ActivatePictureInPicture()
    return
}

#!f:: ; Windows+Alt+F to activate Picture-in-Picture window, fullscreen and unmute
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
#!t:: ; Windows+Alt+T to return to source tab
{
    ReturnToTab()
    return
}

ShowWindowOnAllDesktops() {
    centerWindowX := 270
    centerWindowY := 270
    rightClickMenuRightMovement := 20
    rightClickMenuDownMovement := 120
    
    Send, #{Tab}
    MouseMove, centerWindowX, centerWindowY
    Sleep, 1000
    Click, right
    Sleep, 500
    MouseMove, rightClickMenuRightMovement+centerWindowX, rightClickMenuDownMovement+centerWindowY
    Sleep, 500
    Click
    Sleep, 100
    Send, {Esc}
}
#^a:: ; Win+Ctrl+A show window on all desktops
{
    ShowWindowOnAllDesktops()
    return
}

#^Up:: ; Ctrl+Windows+Up to unmute
{
    WinGet, previousWindow, ID, A  ; Store current active window
    ActivatePictureInPicture()
    if WinActive(PIP_WINDOW) {
        Send, ^{Up}
        WinActivate, ahk_id %previousWindow%  ; Restore previous window
    }
    return
}

#^Down:: ; Ctrl+Windows+Down to mute
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
