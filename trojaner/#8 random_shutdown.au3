#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <AutoItConstants.au3>

;#NoTrayIcon
HotKeySet("{ESC}", "_exit")

;Define min and max value for waitung time (minutes)
$iRandomSleepMin = 1
$iRandomSleepMax = 1
$iRandomSleepInterval = 1

$iRandomSleepCount = Random ($iRandomSleepMin * 60000, $iRandomSleepMax * 60000, $iRandomSleepInterval * 60000)

Sleep ($iRandomSleepCount)

Shutdown (BitOR($SD_FORCE, $SD_SHUTDOWN))			; --> Force a Shutdown

Func _exit()
	Exit
EndFunc
