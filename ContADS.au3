#cs ----------------------------------------------------------------------------

  Author: McLaren Applied Ltd	
  Copyright 2025 McLaren Applied Ltd
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
 
     http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>

; The directory containing the file with the list of raw file to replay
; default if no text file is given

Global $rawFilePath = "C:\tmp\Raw_List.txt"

Dim $rawFiles

;For Debugging
; _ArrayDisplay ($CmdLine)
For $i = 1 To $CmdLine[0]
   $rawFilePath = $CmdLine[$i]
   ; For debugging
   ; MsgBox($MB_SYSTEMMODAL, $rawFilePath, $rawFilePath)
Next

If Not _FileReadToArray ( $rawFilePath, $rawFiles ) Then
    MsgBox(4096, "Error", " Error reading text file to Array error:" & @error)
    Exit
EndIf

; For debugging - shows the list of files
; _ArrayDisplay ( $rawFiles )
;The directory to put the log file
Global $LogDir = "C:\Users\" & @UserName & "\Documents\McLaren Electronic Systems\ATLAS 9\Log"
Global $hFile = FileOpen($LogDir & "\ContADSLog.log", 1)
Global $sLogMsg = ""

; Run ADS
Run("C:\Program Files (x86)\McLaren Electronic Systems\ATLAS 9\Bin\AtlasDataServer.exe")

; Wait for ADS main window
WinWaitActive("Atlas Data Server")

; Press Setup button
ControlClick("Atlas Data Server", "", "Button3")

;Wait for Record dialog
WinWaitActive("Record")
$fileNumber = 1
For $i = 1 To $rawFiles[0]

   $rawFile = $rawFiles[$i]


    WinActivate("Record", "")
    ControlFocus("Record", "", "Edit1")

    ; Construct raw file path
    ; Global $replayFile = $rawFilePath & $rawFile
	Global $replayFile = $rawFile
	$sLogMsg = $rawFilePath & "; Replaying '" & $rawFile & "'; File " & $fileNumber & " out of " & UBound($rawFiles, $UBOUND_ROWS) &";"
    _FileWriteLog ( $hFile, $sLogMsg )

    ; Enter raw filename
    ControlSetText("Record", "", "Edit1", $replayFile)

    ; Press Start button
    ControlClick("Record", "", "Button5")

    ; Wait for recording to start and Start button to become disabled
    Sleep(1000)

    ; Wait for Start button to become enabled again indicating end of recording
    While Not ControlCommand("Record", "", "Button5", "IsEnabled", "")
        Sleep(1000)
    Wend

    Sleep(10000)
    $FileNumber = $FileNumber + 1
 Next

 FileClose($hFile)
