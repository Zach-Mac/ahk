#NoEnv
EnvGet, A_LocalAppData, LocalAppData

#+a::
{
    if WinExist("ahk_exe" anki.exe)
        WinActivate
    else
        Run "%A_LocalAppData%\Programs\Anki\anki.exe"

    WinWaitActive ahk_exe anki.exe
    Send "a"

    Send ^d   
}