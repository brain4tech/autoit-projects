#include "_ImageSearch_UDF.au3"
#include "_ImageSearch_Tool.au3"
#RequireAdmin

HotKeySet("{Esc}", "_Exit") ; Press ESC for exit
Func _Exit()
    Exit 0
EndFunc   ;==>_Exit

Global Const $Ask_On_Found = 0
Global Const $Mouse_Move_On_Found = 1
Global Const $Mouse_Click_On_Found = 0

Global Const $iSleep_Time=500

Global $sCount = 0, $_Image_1 = @ScriptDir & "\example.bmp"

; First, use this function to create a file bmp, maybe a desktop icon for example')
MsgBox(64 + 262144, 'ImageSearch', 'At first, create a file bmp,' & @CRLF & 'photos that will search on the screen!')
_ImageSearch_Create_BMP($_Image_1)

ConsoleWrite("! Search for images: " & $_Image_1 & @CRLF & '! Searching on the screen ...' & @CRLF)

While 1
    ToolTip('(Press ESC for EXIT) Searching ...', 1, 1)
	Sleep($iSleep_Time)
	$sCount += 1
    Local $return = _ImageSearch($_Image_1)
    If $return[0] = 1 Then
        ConsoleWrite('- [' & $sCount & '] Image found:' & " X=" & $return[1] & " Y=" & $return[2] & @CRLF)
        If $Mouse_Move_On_Found Then
			MouseMove($return[1], $return[2])
			Sleep($iSleep_Time)
		EndIf
        If $Mouse_Click_On_Found Then MouseClick("left", $return[1], $return[2])
        ToolTip('(Press ESC for EXIT) - [' & $sCount & "] Image found:" &  " X=" & $return[1] & " Y=" & $return[2], 1, 1)
        If $Ask_On_Found Then
            Local $ask = MsgBox(6 + 262144, 'Success [' & $sCount & ']', 'Image found:' & " X=" & $return[1] & " Y=" & $return[2])
            If $ask = 2 Or $ask = 3 Or $ask = 5 Or $ask = 7 Then Exit ;No, Abort, Cancel, and Ignore
            If $ask = 10 Then _ImageSearch_Create_BMP($_Image_1) ; Continue       ;Try Again
        EndIf
    EndIf
    Sleep(200)
WEnd