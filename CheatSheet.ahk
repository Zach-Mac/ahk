#SingleInstance force

; AUTORELOAD SCRIPT
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



RefreshAllHotkeys()
; Add -Caption to remove the title bar
Gui, +AlwaysOnTop
Gui, Add, ListView, vMyListView, SCRIPT|HOTKEY|COMMENT
BuildListView(allHotkeys)

#h:: ; Toggle CheatSheet GUI
    ToggleGui()
return

#^h:: ; Refresh CheatSheet
    RefreshAllHotkeys()
    Gui, Destroy
    Gui, +AlwaysOnTop
    Gui, Add, ListView, vMyListView, SCRIPT|HOTKEY|COMMENT
    BuildListView(allHotkeys)
    ShowGui()
return


; -- functions -----------------------------------------------------

ShowGui() {
    global Toggle

    GUI, +LastFound ; activate GUI window
	totalWidth := 0 ; initialize ListView width variable
	; get columns' widths       
	Loop % LV_GetCount("Column")
	{
		SendMessage, 4125, A_Index - 1, 0, SysListView321 ; 4125 is LVM_GETCOLUMNWIDTH.
		totalWidth := totalWidth + ErrorLevel
	}
	; resize ListView control width
	GuiControl, Move, MyListView, % "W" . totalWidth + 8

	; resize ListView control height
    numRows := LV_GetCount()    
    GuiControl Move, SysListView321, % "h" 20 * numRows + 22

    ; resize and show GUI
    Gui, Show, AutoSize, All Script Hotkeys
    Toggle := true
}

HideGui() {
    global Toggle
    Gui, Hide
    Toggle := false
}

ToggleGui() {
    global Toggle
    if (Toggle) {
        HideGui()
    } else {
        ShowGui()
    }
}

RefreshAllHotkeys() {
    global allHotkeys
    allHotkeys := []
    DetectHiddenWindows, On
    WinGet, id, List, ahk_class AutoHotkey
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        if RegExMatch(title, "([^\s\\/:]+\.ahk)(\.exe)?", match) {
            scriptName := match1 . (match2 ? match2 : "")
            scriptPath := "c:\Dev\ahk\" . match1
            if FileExist(scriptPath) {
                hotkeys := HotkeysFromFile(scriptPath)
                allHotkeys.Push({ Script: scriptName, Hotkey: "", Comment: "" }) ; add empty line for better readability
                if (hotkeys.MaxIndex())
                    for _, elt in hotkeys
                        allHotkeys.Push({ Script: "", Hotkey: elt.Hotkey, Comment: elt.Comment })
                else
                    allHotkeys.Push({ Script: scriptName, Hotkey: "", Comment: "" })
            }
            ; For proper scriptnames in rows
            ; if FileExist(scriptPath) {
            ;     hotkeys := HotkeysFromFile(scriptPath)
            ;     if (hotkeys.MaxIndex())
            ;         for _, elt in hotkeys
            ;             allHotkeys.Push({ Script: scriptName, Hotkey: elt.Hotkey, Comment: elt.Comment })
            ;     else
            ;         allHotkeys.Push({ Script: scriptName, Hotkey: "", Comment: "" })
            ; }
        }
    }
}

BuildListView(hotkeyArray) {
    GuiControl,, MyListView  ; ensure it exists
    LV_Delete()
    for _, elt in hotkeyArray
        LV_Add("", elt.Script, elt.Hotkey, elt.Comment)
    LV_ModifyCol()
}

HotkeysFromFile(scriptPath) {
    FileRead, Script, %scriptPath%
    Script := RegExReplace(Script, "ms`a)^\s*/\*.*?^\s*\*/\s*|^\s*\(.*?^\s*\)\s*")
    hotkeys := []
    Loop, Parse, Script, `n, `r
        ; 1) (.+?)  = hotkey up to the first ‘::’  
        ; 2) (?:.*?;\s*)?  = optionally skip everything through the first ‘;’  
        ; 3) (.*)   = capture either the comment (if ‘;’ was present) or the body 
        if RegExMatch(A_LoopField, "^\s*([^\s:]+)::(?:.*?;\s*)?(.*)$", M) {
            hkey := M1, comment := M2
            if !RegExMatch(hkey, "(Shift|Alt|Ctrl|Win)")
            {
                StringReplace, hkey, hkey, +, Shift+
                StringReplace, hkey, hkey, <^>!, AltGr+
                StringReplace, hkey, hkey, <, Left, All
                StringReplace, hkey, hkey, >, Right, All 
                StringReplace, hkey, hkey, !, Alt+
                StringReplace, hkey, hkey, ^, Ctrl+
                StringReplace, hkey, hkey, #, Win+
            }
            SplitPath, scriptPath, scriptFile
            ; MsgBox, % "Script: " scriptFile "`nHotkey: " hotkey "`nComment: " comment
            hotkeys.Push({ Script: scriptFile, Hotkey: hkey, Comment: comment })
        }
    return hotkeys
}


; Read Hotkeys from CURRENT Script File
; Hotkeys(ByRef Hotkeys)
; {
;     FileRead, Script, %A_ScriptFullPath%
;     Script :=  RegExReplace(Script, "ms`a)^\s*/\*.*?^\s*\*/\s*|^\s*\(.*?^\s*\)\s*")
;     Hotkeys := {}
;     Loop, Parse, Script, `n, `r
;         if RegExMatch(A_LoopField,"^\s*(.*):`:.*`;\s*(.*)",Match)
;         {
;             if !RegExMatch(Match1,"(Shift|Alt|Ctrl|Win)")
;             {
;                 StringReplace, Match1, Match1, +, Shift+
;                 StringReplace, Match1, Match1, <^>!, AltGr+
;                 StringReplace, Match1, Match1, <, Left, All
;                 StringReplace, Match1, Match1, >, Right, All 
;                 StringReplace, Match1, Match1, !, Alt+
;                 StringReplace, Match1, Match1, ^, Ctrl+
;                 StringReplace, Match1, Match1, #, Win+
;             }
;             Hotkeys.Push({"Hotkey":Match1, "Comment":Match2})
;         }
;     return Hotkeys
; }

; ; Show all running AHK scripts
; DetectHiddenWindows, On
; WinGet, id, List, ahk_class AutoHotkey
; scripts := ""
; Loop, %id%
; {
;     this_id := id%A_Index%
;     WinGetTitle, title, ahk_id %this_id%
;     scripts .= title "`n"
;     if RegExMatch(title, "([^\s\\/:]+\.ahk(?:\.exe)?)", match)
;         scripts2 .= match1 "`n"
; }
; MsgBox, Running AHK scripts:`n`n%scripts%`n%scripts2%
