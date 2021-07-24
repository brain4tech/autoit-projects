#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	Autoclicker for MagicTiles3 in a Memu-Emulator

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstantsEx.au3>
#include <Array.au3>

Opt("GuiOnEventMode", 1)

HotKeySet ("{ESC}", "_exit")

$sHandleName = "MEmu"
$bStop = False

$hGUI = GUICreate("PianoTiles-Clicker", 259, 43, 192, 124)
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
	ConsoleWrite("Start your game." & @CRLF)

	;Compute Rectangle Area
	$rTop = $hPos[1] + $hPos[3] - 2* int($hPos[3]/5)
	$rBottom =$hPos[1] + $hPos[3] - 2*int($hPos[3]/5) + 10

	$iQuarterWidth = $hPos[2]/4

	$rgbColor = 0x000000

	While $bStop <> True

		For $i = 0 To 3 Step 1
			$rLeft = $hPos[0] + $i * $iQuarterWidth
			$rRight = $hPos[0] + $hPos[2] - ((3-$i)*$iQuarterWidth)

			MouseMove ($hPos[0] + $i * $iQuarterWidth + $iQuarterWidth/2, $rTop, 0)
			$aMousePos = MouseGetPos()

			$iPSearch = PixelSearch ($aMousePos[0] - 2, $aMousePos[1] - 2 - 70, _
				$aMousePos[0] + 2, $aMousePos[1] + 2 + 70, $rgbColor, 50)

			If not @error Then MouseClick ("primary")
		Next

	WEnd

EndFunc

Func _stop()
	GUICtrlSetState ($iStop, $GUI_DISABLE)
	GUICtrlSetState ($iStart, $GUI_ENABLE)

	$bStop = True

EndFunc

Func _exit()
	Exit
EndFunc
