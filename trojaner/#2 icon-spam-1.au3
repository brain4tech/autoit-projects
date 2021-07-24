#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	A simple Virus which creates icons on the desktop once in a while just to troll your friends.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#NoTrayIcon

#include <File.au3>

;HotKeySet ("{ESC}", "_Exit")

Sleep (180000)

While 1

	_FileCreate (@DesktopDir & "\.lnk")

	Sleep (Random (2000, 60000, 1000))

WEnd

Func _Exit ()
	Exit
EndFunc
