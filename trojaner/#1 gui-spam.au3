#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	A simple Virus which creates simple GUIs once in a while just to troll your friends.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#NoTrayIcon

HotKeySet ("{ESC}", "_Exit")

Sleep (180000)

While 1

	GUICreate ("", 300, 100, Random (1, @DesktopWidth - 300), Random (1, @DesktopHeight - 100))
	GUISetState ()

	Sleep (Random (2000, 60000, 1000))

WEnd

Func _Exit ()
	Exit
EndFunc
