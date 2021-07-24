#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Misc.au3>

#NoTrayIcon

HotKeySet ("{ESC}", "_exit")

While 1

	;Zeitabschnitt wann die Eingabe gestoppt werden soll
	Sleep (Random (2000, 5000, 1000))

	$mousecoords = MouseGetPos ()
	_MouseTrap ($mousecoords[0], $mousecoords[1])

	;Länge für das Stoppen der Eingabe
	Sleep (Random (2000, 5000, 1000))

	_MouseTrap ()

WEnd

Func _exit ()

	_MouseTrap ()
	Exit

EndFunc
