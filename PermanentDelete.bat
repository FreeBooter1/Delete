:: Add Permanently Delete to Context Menu in Windows 10 and Windows 11

@Echo Off 

(Net session >nul 2>&1)||(PowerShell start """%~0""" -verb RunAs & Exit /B)	


:_Ask
Cls & Mode CON  LINES=11 COLS=90 & Color 0E & Title Created By FreeBooter
Echo.
Echo.
Echo.
Echo.       
Echo        Do You Want To Add "Permanently Delete" to Context Menu (A)?   
Echo.       
Echo        Do You Want To Remove "Permanently Delete" from Context Menu (R)?
Echo.


Set /p input=:^> 

If /i  Not %input%==A (Goto :_Ex) Else (Goto :_Start) 

:_Ex
If /i Not %input%==R  (Goto :_Ask) Else (Goto :_RegRestore)



:_Start

Reg add "HKCR\*\shell\Windows.PermanentDelete" /v "CommandStateSync" /t REG_SZ /d "" /f > Nul
Reg add "HKCR\*\shell\Windows.PermanentDelete" /v "ExplorerCommandHandler" /t REG_SZ /d "{E9571AB2-AD92-4ec6-8924-4E5AD33790F5}" /f >Nul 
Reg add "HKCR\*\shell\Windows.PermanentDelete" /v "Icon" /t REG_SZ /d "shell32.dll,-240" /f >Nul 
Reg add "HKCR\Directory\shell\Windows.PermanentDelete" /v "CommandStateSync" /t REG_SZ /d "" /f >Nul 
Reg add "HKCR\Directory\shell\Windows.PermanentDelete" /v "ExplorerCommandHandler" /t REG_SZ /d "{E9571AB2-AD92-4ec6-8924-4E5AD33790F5}" /f >Nul 
Reg add "HKCR\Directory\shell\Windows.PermanentDelete" /v "Icon" /t REG_SZ /d "shell32.dll,-240" /f >Nul 




Cls & Mode CON  LINES=11 COLS=60 & Color 0E & Title Created By FreeBooter
Echo.
Echo.
Echo.
Echo.
Echo          Permanently Delete Context Menu Enabled   
Echo.
Echo.
Echo. 

Taskkill /im Explorer.exe /f >Nul

Start Explorer.exe

ping -n 6 localhost >Nul 
Exit


:_RegRestore

Reg Query "HKCR\*\shell\Windows.PermanentDelete"  > Nul

If %ErrorLevel% EQU 1 Goto :EOF

Reg delete "HKCR\*\shell\Windows.PermanentDelete" /f > Nul

Reg delete "HKCR\Directory\shell\Windows.PermanentDelete" /f > Nul


Cls & Mode CON  LINES=11 COLS=60 & Color 0E & Title Created By FreeBooter
Echo.
Echo.
Echo.
Echo.
Echo         Permanently Delete Context Menu Removed    
Echo.
Echo.
Echo. 

Taskkill /im Explorer.exe /f >Nul

Start Explorer.exe

ping -n 5 localhost >Nul 
Exit