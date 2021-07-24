#include <WindowsConstants.au3>

Opt("GuiOnEventMode", 1)

$pathToFile = ""
$pathToAutostart = @AppDataDir & "\Microsoft\Windows\Start Menu\Programs\Startup"


#Region ### GUI ###

$hGUI = GUICreate("Nach Autostart kopieren", 768, 75, 192, 124, Default, $WS_EX_ACCEPTFILES)
	GUISetOnEvent (-3, "_exit")
$lPath = GUICtrlCreateLabel("Dateipfad", 8, 11, 50, 17)
$iPath = GUICtrlCreateInput("", 64, 8, 601, 21)
	GUICtrlSetState (-1, 8) ; 8 = $GUI_DROPACCEPTED
$bSearch = GUICtrlCreateButton("Suchen", 672, 6, 83, 25)
	GUICtrlSetOnEvent (-1, "_searchFile")
$bCopy = GUICtrlCreateButton("Kopieren", 624, 40, 131, 25)
	GUICtrlSetOnEvent (-1, "_copyToAutostart")
$bLink = GUICtrlCreateButton("Verknüpfung erstellen", 488, 40, 131, 25)
	GUICtrlSetOnEvent (-1, "_linkToAutostart")
$lStatus = GUICtrlCreateLabel("Programm erfolgreich gestartet.", 8, 43, 300, 17)
$bAutostart = GUICtrlCreateButton("Autostart öffnen", 352, 40, 131, 25)
	GUICtrlSetOnEvent (-1, "_openAutostart")

GUISetState(@SW_SHOW)

#EndRegion ### GUI ###

While (1)

	Sleep (10)

WEnd


Func _searchFile ()
	$pathToFile = FileOpenDialog  ("Datei suchen ...", @DesktopDir, "Alles (*.*)", 1 + 2, Default, $hGUI)
	If $pathToFile <> "" Then
		GUICtrlSetData ($iPath, $pathToFile)
		_changeStatus ("Datei erfolgreich geladen.")
	Else
		_changeStatus ("Es wurde keine Datei geladen.")
	EndIf

EndFunc

Func _copyToAutostart ()
	$success = FileCopy  (_getFilePath (), $pathToAutostart, 1)

	If $success == 1 Then
		_changeStatus ("Datei wurde erfolgreich kopiert.")
	Else
		_changeStatus ("Datei konnte nicht kopiert werden.")
	EndIf


EndFunc

Func _linkToAutostart ()

	$filepath =  _getFilePath ()

	$aStringSplit = StringSplit ($filepath, "\")
	$filename = $aStringSplit[UBound($aStringSplit) -1 ]
	;ConsoleWrite($filename & @CRLF)

	$success = FileCreateShortcut ($filepath, $pathToAutostart & "/" & $filename)
	If $success == 1 Then
		_changeStatus ("Verknüpfung wurde erfolgreich erstellt.")
	Else
		_changeStatus ("Datei konnte nicht verknüpft werden.")
	EndIf

EndFunc

Func _openAutostart ()
	Run ("Explorer.exe " & $pathToAutostart)
	_changeStatus ("Autostart wird geöffnet.")
EndFunc

Func _getFilePath()
	Return GUICtrlRead ($iPath)
EndFunc

Func _changeStatus($input)
	GUICtrlSetData ($lStatus, $input)
EndFunc

Func _exit ()
	_changeStatus ("Programm wird beendet ...")
	Sleep (300)
	Exit
EndFunc

