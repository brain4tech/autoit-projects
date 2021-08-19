#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Brain4Tech

 Script Function:
	This script starts all *.exe-files in a defined directory

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <File.au3>
#include <Array.au3>

$dir = ".\au3"

; Set min and max for randomness (in seconds)
$sleepmin = 1
$sleepmax = 3


$exes_in_dir = _FileListToArray ($dir, "*.exe")

;_ArrayDisplay ($exes_in_dir)

For $i = 1 To $exes_in_dir[0] Step 1

	Sleep (Random($sleepmin *1000, $sleepmax*1000, 200))

	ShellExecute ($dir & "\" & $exes_in_dir[$i])
	ConsoleWrite("Started virus: " & $exes_in_dir[$i] & @CRLF)
Next
