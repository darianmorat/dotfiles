#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv ; Recommended for performance and compatibility with future AHK releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
SendMode Input ; For new scripts due to its superior speed and reliability

; ====================
; ==== KEYBD MAIN ====
; ====================

; VORTEX CYPHER:
; LSpc ----- to LAlt
; LAlt ----- to Fn
; Fn-z ----- to Fn-a

!t::
toggle:=!toggle
If toggle
Send, !{Esc}
else
Send, !+{Esc}
return

!j::
send, {down}
return
!k::
send, {up}
return
^!h::
send, {left}
return
^!l::
send, {right}
return
!h::
send, {backspace}
return
!l::
send, {enter}
return

!u::
return
!p::
return

!i::
SendRaw {
return
!o::
SendRaw }
return
!9::
send, (
return
!0::
send, )
return
![::
send, ]
return
!]::
send, ]
return

!w::
send, {^}
return
!e::
send, {$}
return
!s::
send, {B}
return
!d::
send, {W}
return
!r::
send, =
return
!f::
send % "{Raw}%"
return

!-::
send, {_}
return
*=::
send, {+}
return
!\::
send, |
return
!;::
send, :
return
!'::
send, "
return
!,::
send, <
return
!.::
send, >
return
!/::
send, ?
return

*Esc::
send, ``
return
*+Esc::
send, ~
return

; ==================
; ===== BRIGHT =====
; ==================

!+-:: ;Brightness Down
  AdjustScreenBrightness(-10)
  Return
!+=:: ;Brightness Up
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

!g::
    Toggle := !Toggle
    If (Toggle)
        WinSet, Transparent, 0, ahk_class Shell_TrayWnd
    Else
        WinSet Transparent, 255, ahk_class Shell_TrayWnd
    Return

; ================
; ==== CHROME ====
; ================

#IfWinActive, ahk_exe brave.exe

    ; Ctrl - Home / End
    !w::
    send, {Home}
    return
    !+w::
    send, {ShiftDown}{Home}{ShiftUp}}
    return
    !e::
    send, {End}
    !+e::
    send, {ShiftDown}{End}{ShiftUp}}
    return

    ; Ctrl - Right / Left
    !d::
    send, {CtrlDown}{Right}{CtrlUp}
    return
    !+d::
    send, {CtrlDown}{ShiftDown}{Right}{CtrlUp}{ShiftUp}
    return
    !s::
    send, {CtrlDown}{Left}{CtrlUp}
    return
    !+s::
    send, {CtrlDown}{ShiftDown}{Left}{CtrlUp}{ShiftUp}
    return

#IfWinActive

; ==================
; ===== CENTER =====
; ==================

; !Enter::
; SysGet Mon,MonitorWorkArea
; WinGetPos ,,,wW,wH,A
; WinMove A,,(MonRight-wW)/2,(MonBottom-wH)/2-16
; Return

; ==================
; ==== MODIFIER ====
; ==================

LCtrl::CapsLock
CapsLock::Ctrl

$Alt::
   KeyWait, Alt, T0.16
   If ErrorLevel
   {
      return
   }
   Send {Esc}
Return

; ==================
; ===== MACROS =====
; ==================

:*?:;date::
Send %A_MM%-%A_DD%-%A_YYYY%
return

:*?:;time::
FormatTime, currentTime,, h:mm tt
Send %currentTime%
return
