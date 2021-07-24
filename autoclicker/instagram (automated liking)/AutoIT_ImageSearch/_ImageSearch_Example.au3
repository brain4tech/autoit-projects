#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;~ #AutoIt3Wrapper_UseX64=y
;  #AutoIt3Wrapper_Change2CUI=y

#include "_ImageSearch.au3"
#include "_ImageSearch_Tool.au3"

HotKeySet("{Esc}", "_Exit")
Func _Exit()
	Exit 0
EndFunc   ;==>_Exit

_ImageSearch_Example()

Func _ImageSearch_Example()
	; At first. You have to create 2 file Seach.bmp and Seach_Me.bmp of your screen (i.e some icon)
	;==> create Image for Search
	MsgBox(64, 'ImageSearch', 'At first, use this function to create 2 file bmp, maybe a desktop icon for example')
	Local $_Image_1 = @ScriptDir & "\Seach_1.bmp"
	Local $_Image_2 = @ScriptDir & "\Seach_2.bmp"

	_ImageSearch_Create_BMP($_Image_1)
	;_ImageSearch_Create_BMP($_Image_2)

	Local $find_ListImage = $_Image_1 & '|' & $_Image_2

	;==>Example 1 - Return Position Center
	MsgBox(0, 'Example 1', 'Check if an Image appear on your screen')
	Local $return = _ImageSearch($_Image_1)
	If $return[0] = 1 Then
		MsgBox(0, 'Ex 1 - Success', 'Image found:' & " X=" & $return[1] & " Y=" & $return[2] & @CRLF & $_Image_1)
	Else
		MsgBox(48, 'Ex 1 - Failed', 'Image not found')
	EndIf

	;==>Example 1
;~ 	MsgBox(0, 'Example 1', 'Check if an Image appear on your screen')
	Local $return = _ImageSearch($_Image_1, 200, False)
	If $return[0] = 1 Then
		MsgBox(0, 'Ex 1: IMG2 - Success', 'Image found:' & " X=" & $return[1] & " Y=" & $return[2] & @CRLF & $_Image_2)
	Else
		MsgBox(48, 'Ex 1: IMG2 - Failed', 'Image not found')
	EndIf

	;==>Example 2
	MsgBox(0, 'Example 2', 'Check an of list image appear on your screen. Move mouse to it')
	Local $return = _ImageSearch($find_ListImage)
	If $return[0] == 1 Then MouseMove($return[1], $return[2])

	;==>Example 2
;~ 	MsgBox(0, 'Example 2', 'Check an of list image appear on your screen. Move mouse to it')
	Local $return = _ImageSearch($find_ListImage)
	If $return[0] == 1 Then MouseMove($return[1], $return[2])

	;==>Example 3
	MsgBox(0, 'Example 3', 'Check if an of list image appear on your screen. Move mouse to it. Use _ImageSearchWait with timeout')
	Send("#d")
	Sleep(300)
	Local $r = Run('notepad', '', @SW_MAXIMIZE)
	MsgBox(262144, 'Example 3', 'Wait a moment then try to close notepad and show your desktop to see you icon example')
	Local $return = _ImageSearch_Wait($find_ListImage, 10000)
	If $return[0] = 1 Then
		MsgBox(0, 'Success', 'Image found' & @CRLF & " X:" & $return[1] & " Y:" & $return[2])
		MouseMove($return[1], $return[2])
	Else
		MsgBox(48, 'Failed', 'Image not found')
	EndIf
	WinClose("Untitled - Notepad")
EndFunc   ;==>_ImageSearch_Example

; * -----:| Dao Van Trong - TRONG.LIVE
