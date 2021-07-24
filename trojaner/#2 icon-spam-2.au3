#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#NoTrayIcon
#include <File.au3>

HotKeySet ("{ESC}", "_exit")

$number = 0

_FileCreate (@MyDocumentsDir & "\It's a PRANK")
Sleep (500)

While 1
	$check = FileCreateShortcut (@MyDocumentsDir & "\It's a PRANK", @DesktopDir & "\It's a PRANK" & $number)
	$number = $number + 1

	Sleep (Random(20000, 180000, 1000))
WEnd


Func _exit ()
	Exit
EndFunc