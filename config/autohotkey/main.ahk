#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv ; Recommended for performance and compatibility with future AHK releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
SendMode Input ; For new scripts due to its superior speed and reliability

; ==================
; ===== BRIGHT =====
; ==================

!+-:: 
  AdjustScreenBrightness(-10)
  Return
!+=::
  AdjustScreenBrightness(10)
  Return
  
AdjustScreenBrightness(step) {
    service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    minBrightness := 5

    for i in monitors {
        curt := i.CurrentBrightness
        break
    }
    if (curt < minBrightness)
        curt := minBrightness
    toSet := curt + step
    if (toSet > 100)
        return
    if (toSet < minBrightness)
        toSet := minBrightness
    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}

; ==================
; ===== TASKBR =====
; ==================

!+h::
    Toggle := !Toggle
    If (Toggle)
        WinSet, Transparent, 0, ahk_class Shell_TrayWnd
    Else
        WinSet Transparent, 255, ahk_class Shell_TrayWnd
    Return

; ==================
; ===== MACROS =====
; ==================
; Macros are not working due to the priority with kanata keymaps, find a way to make it 
; work with ahk or with any other external app. For now just focus in kanata config

:*?:;date::
Send %A_MM%-%A_DD%-%A_YYYY%
return

:*?:;time::
FormatTime, currentTime,, h:mm tt
Send %currentTime%
return
