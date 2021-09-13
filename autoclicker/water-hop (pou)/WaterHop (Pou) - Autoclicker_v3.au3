#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech (www.youtube.de/brain4tech)

 Script Function:
	Autoclicker for Pou's WaterHop! (https://youtu.be/8vzi1bjPCq4) in a Memu-Emulator

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <Misc.au3>

Opt("GuiOnEventMode", 1)

HotKeySet ("{ESC}", "_exit")

$sHandleName = "(Pou-Memu)"
$bStop = False

$hGUI = GUICreate("TwoWays!-Clicker", 259, 43, 192, 124)
	GUISetOnEvent (-3, "_exit")
$iStart = GUICtrlCreateButton("Find and Start", 16, 8, 105, 25)
	GUICtrlSetOnEvent (-1, "_start")
$iStop = GUICtrlCreateButton("Stop", 136, 8, 105, 25)
	GUICtrlSetOnEvent (-1, "_stop")
	GUICtrlSetState (-1, $GUI_DISABLE)
GUISetState(@SW_SHOW)

While 1
	Sleep (10)
WEnd

Func _start()
	GUICtrlSetState ($iStart, $GUI_DISABLE)
	GUICtrlSetState ($iStop, $GUI_ENABLE)

	$hTilesHandle = WinGetHandle($sHandleName)

	If @error Then
		MsgBox (0, "Error: Handle not found", "The handle of the Emulator hasn't been found. Please start the app and retry.")
		Return
	EndIf

	ConsoleWrite("Please click on the desired Handle to continue" & @CRLF)
	Sleep (1000)

	$tempvar = 0

	While (1)

		If WinActive ($sHandleName) == 0 Then
			if $tempvar <> 1 Then ConsoleWrite("Window is not active" & @CRLF)
			$tempvar = 1
			Sleep (1000)
		Else
			ExitLoop
		EndIf
	WEnd

	$hPos = WinGetPos ("[ACTIVE]") ;[0] = X, [1] = Y, [2] = Width, [3] = Height

	ConsoleWrite("Window Characteristics: X=" & $hPos[0] & ", Y=" & $hPos[1] & _
		", Width=" & $hPos[2] & ", Height=" & $hPos[3] & @CRLF)

	;get position 1 where to perform pixel checks
	ConsoleWrite("Click at ideal pos for rubber ring 1" & @CRLF)

	While (NOT _IsPressed(01))
		Sleep (10)
	WEnd

	$pos_1 = MouseGetPos()
	ConsoleWrite("Position stored: " & $pos_1[0] & " | " & $pos_1[1] & @CRLF)

	Sleep (500)

	;get position 2 where to perform pixel checks
	ConsoleWrite("Click at ideal pos for rubber ring 2" & @CRLF)

	While (NOT _IsPressed(01))
		Sleep (10)
	WEnd

	$pos_2 = MouseGetPos()
	ConsoleWrite("Position stored: " & $pos_2[0] & " | " & $pos_2[1] & @CRLF)


	ConsoleWrite("Game is starting" & @CRLF)

	;Compute variables
	$xcentre = $hPos[0] + $hPos[2]/2
	$ycentre = $hPos[1] + $hPos[3]/2

	$xoffset = 50

	$yellow = 0xFFFF00
	$yellow_coin = 0xFFE700
	$blue = 0x42D7FF
	$white = 0xFFFFFF
	$white_time = 0xFFFFFF
	$green = 0x31FF31

	$sleep_count = 150

	$ps_x_offset = 70
	$ps_y_offset = 40
	$ps_y_height = 60

	$left = $pos_1[0] - $ps_x_offset
	$top = $pos_1[1] - $ps_y_offset - $ps_y_height
	$right = $pos_1[0] + $ps_x_offset
	$bottom = $pos_1[1] - $ps_y_offset

	While $bStop <> True

		; Search for pixelcolor above first rubber ring

		PixelSearch($left, $top, $right, $bottom, $yellow_coin, 50)

		If Not @error Then
			ConsoleWrite("coin" & @CRLF)
			MouseClick("primary", $xcentre - $xoffset, $pos_1[1], 1, 0)	; left
			ContinueLoop
		EndIf

		PixelSearch($left, $top, $right, $bottom, $white_time, 50)
		If Not @error Then
			ConsoleWrite("time" & @CRLF)
			MouseClick("primary", $xcentre - $xoffset, $pos_1[1], 1, 0)	; left
			ContinueLoop
		EndIf

		; Get pixelcolor at given points
		$color_1 = PixelGetColor($pos_1[0], $pos_1[1])
		$color_2 = PixelGetColor($pos_2[0], $pos_2[1])

		If $color_1 == $yellow AND $color_2 == $blue Then
			ConsoleWrite("else" & @CRLF)
			MouseClick("primary", $xcentre - $xoffset, $pos_1[1], 1, 0)	; left

		ElseIf $color_1 == $blue AND $color_2 == $yellow Then
			ConsoleWrite("else" & @CRLF)
			MouseClick("primary", $xcentre + $xoffset, $pos_1[1], 1, 0) ; right

		ElseIf $color_1 == $yellow AND $color_2 == $yellow Then
			ConsoleWrite("else" & @CRLF)
			MouseClick("primary", $xcentre + $xoffset, $pos_1[1], 1, 0) ; right

		EndIf

		If $color_1 = $white Then
			MouseMove($pos_1[0], $pos_1[1], 0)
			Exit
		EndIf

		If $color_1 = $green Then
			MouseClick("primary", $pos_1[0], $pos_1[1], 1, 0)
		EndIf

	Wend

EndFunc

Func _stop()
	GUICtrlSetState ($iStop, $GUI_DISABLE)
	GUICtrlSetState ($iStart, $GUI_ENABLE)

	$bStop = True

EndFunc

Func _exit()
	Exit
EndFunc
