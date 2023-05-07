; This script changes display brightness using AutoHotkey version 2.0


; This script should writen in auto-execution area
; Display screen dimmer on start up
; 0 (Bright) ~ 255 (Black)
DefaultDimDay := 0 ; Brightness from 6 AM to 18 PM
DefaultDimNight := 31 ; Brightness from 18 PM to 6 AM
DefaultDim()

; This script can be written anywhere except for application-specific (such as #IfWinExist and #IfWinActive) area.
; Change brightness by Win + Alt + Left/Right
; Dim: 0 (Bright) ~ 255 (Black)
#!Left::
{
	If (Dim < 223) {
		global Dim := Dim + 16
		ScreenDimmer()
	}
	Return
}

#!Right::
{
	If (Dim >= 16) {
		global Dim := Dim - 16
	} Else {
		global Dim := 0
	}
	ScreenDimmer()
	Return
}

; Restore ScreenDimmer
; Restore ScreenDimmer
; 0 (Bright) ~ 255 (Black)
#!0::
{
	global Dim := 0
	ScreenDimmer()
	Return
}

; Set ScreenDimmer
#!9::
#!8::
#!7::
{
	If WinActive("ScreenDimmer") {
		Return
	} Else {
		global Dim := 0
		If GetKeyState("9", "P") {
			global Dim := 127
		}
		If GetKeyState("8", "P") {
			global Dim := 191
		}
		If GetKeyState("7", "P") {
			global Dim := 223
		}
		ScreenDimmer()
	}
	Return
}


; ScreenDimmer gosub command
; Screen dimmer
ScreenDimmer()
{
	ScreenSize := GetScreenSize()
	If not WinExist("ScreenDimmer") {
		ScreenDimmer := Gui("+AlwaysOnTop", "ScreenDimmer")
		ScreenDimmer.BackColor := "Black"
		ScreenDimmer.Opt("-Caption +E0x20 +ToolWindow")
		ScreenDimmer.Show(Format("x{1:} y{2:} w{3:} h{4:}", ScreenSize*))
	}
	WinSetTransparent Dim, "ScreenDimmer"
	If IsSet(ActiveTitle) {
		If WinExist(ActiveTitle) {
			WinActivate ActiveTitle
		}
	}
	Return
}

DefaultDim()
{
	If (DefaultDimDay >= 0 AND DefaultDimNight >= 0) {
		Time := FormatTime(, "H") ; Current time
		If (Time > 6 AND Time < 18) { ; Daytime
			If (DefaultDimDay >= 0 AND DefaultDimDay < 256) {
				global Dim := DefaultDimDay
			} Else {
				global Dim := 0
			}
		} Else {		
			If (DefaultDimNight >= 0 AND DefaultDimNight < 256) {
				global Dim := DefaultDimNight
			} Else {
				global Dim := 127
			}
		}
		ScreenDimmer()
	}
	Return
}
