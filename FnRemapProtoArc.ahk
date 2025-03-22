; #InstallKeybdHook
; #InstallMouseHook

; #SingleInstance force
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

; ^F1::Volume_Mute
; ^F2::Volume_Down
; ^F3::Volume_Up

^F1::Volume_Down
^F2::Volume_Up
^F3::Volume_Mute