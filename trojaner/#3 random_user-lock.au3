#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#NoTrayIcon

While 1

	Sleep (Random (60000, 180000, 1000))

	ShellExecute("rundll32.exe", 'user32.dll,LockWorkStation')

WEnd
