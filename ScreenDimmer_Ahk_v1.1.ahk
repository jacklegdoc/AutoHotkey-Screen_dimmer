; This script changes display brightness using AutoHotkey version 1.1
; This script uses Gui 10 but can changed if used for other script.


; This script should writen in auto-execution area
; Display screen dimmer on start up
; 0 (Bright) ~ 255 (Black)
DefaultDimDay := 0 ; Brightness from 6 AM to 18 PM
DefaultDimNight := 31 ; Brightness from 18 PM to 6 AM

If IsSet(DefaultDimDay) OR IsSet(DefaultDimNight)
{
	FormatTime, time, , H
	If (time > 6 AND time < 18)
	{
		If (DefaultDimDay >= 0 AND DefaultDimDay <= 255)
		{
			Dim := DefaultDimDay
		} Else {
			Dim := 0
		}
	} Else {		
		If (DefaultDimNight >= 0 AND DefaultDimNight <= 255)
		{
			Dim := DefaultDimNight
		} Else {
			Dim := 63
		}
	}
	Gosub, ScreenDimmer
}


; This script can be written anywhere except for application-specific (such as #IfWinExist and #IfWinActive) area.
; Change brightness by Win + Alt + Left/Right
; Dim: 0 (Bright) ~ 255 (Black)
#!Left::
{
	If (Dim < 223)
	{
		Dim := Dim + 16
		Gosub, ScreenDimmer
	}
	Return
}

#!Right::
{
	If (Dim >= 16)
	{
		Dim := Dim - 16
		Gosub, ScreenDimmer
	}
	Return
}

; Restore ScreenDimmer
#!0::
{
	Dim := 0 ; 0 (Bright) ~ 255 (Black)
	Gosub, ScreenDimmer
	Return
}

; Set ScreenDimmer
#!9::
{
	Dim := 127 ; 0 (Bright) ~ 255 (Black)
	Gosub, ScreenDimmer
	Return
}

#!8::
{
	Dim := 191 ; 0 (Bright) ~ 255 (Black)
	Gosub, ScreenDimmer
	Return
}

#!7::
{
	Dim := 223 ; 0 (Bright) ~ 255 (Black)
	Gosub, ScreenDimmer
	Return
}


; ScreenDimmer gosub command
ScreenDimmer:
{
	SysGet, ScreenLeft, 76
	SysGet, ScreenTop, 77
	SysGet, ScreenWidth, 78
	SysGet, ScreenHeight, 79
	WinGet, ActiveID, IDLast, A
	Gui, 10: Color, 000000
	Gui, 10: -Caption +AlwaysOnTop +E0x20 +HwndhGui +ToolWindow
	Gui, 10: Show, % Format("x{} y{} w{} h{}", ScreenLeft, ScreenTop, ScreenWidth, ScreenHeight), ScreenDimmer
	WinSet, Transparent, % Dim, % "ahk_id " hGui
	WinActivate, % "ahk_id " hWnd
	;WinSet, AlwaysOnTop, On, ahk_class Shell_TrayWnd ; Taskbar always on top does not work.
	WinActivate, ahk_id %ActiveID%
	Return
}
