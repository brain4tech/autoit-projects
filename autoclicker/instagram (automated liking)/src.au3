#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	Automatically likes every post on the screen

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include "./AutoIT_ImageSearch/_ImageSearch.au3"

HotKeySet ("{ESC}", "_exit")

$wintitle = "Instagram - Brave"
$imgpath = @ScriptDir & "\media\like-empty.bmp"
ConsoleWrite($imgpath & @CRLF)

$winPos = WinGetPos ($wintitle) ;0:X, 1:Y, 2:Width, 3:Height
If @error Then
	ConsoleWrite("No window with matching title. Terminating ..." & @CRLF)
	Exit
Else
	ConsoleWrite("Found matching window at (" & $winPos[0] & "|" & $winPos[1] & ") with size of " & $winPos[2] & "x" & $winPos[3] & @CRLF)
	WinActivate ($wintitle)
EndIf

MouseMove($winPos[0] + $winPos[2]/2, $winPos[1] + $winPos[3]/2, 0)

While True

	;Parameter _ImageSearch_Area : Bildpfad, Position oben-links, Position unten-rechts, Toleranz, Zentrum = True
	;Ausgabe (Array): 0:Gefunden Ja/Nein, 1:X-Koordinate, 2:Y-Koordinate
	$searchresults = _ImageSearch_Area ($imgpath, $winPos[0], $winPos[1], $winPos[0] + $winPos[2], $winPos[1] + $winPos[3], 50)
	If $searchresults[0] == 1 Then
		ConsoleWrite("Match at " & $searchresults[1] & "|" & $searchresults[2] & "!" & @CRLF)
		MouseMove($searchresults[1], $searchresults[2], 0)
		MouseClick("primary")
		Sleep (300)
	Else
		ConsoleWrite("No Match ..." & @CRLF)
	EndIf

	MouseWheel("down", 4)
	Sleep (200)

WEnd


Func _exit()
	Exit
EndFunc