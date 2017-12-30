@echo OFF
::@set DAY=%date:~6,4%.%date:~3,2%.%date:~0,2%
set DAY=%date:~8,2%.%date:~3,2%.%date:~0,2%
set NOW=%time:~0,2%%time:~3,2%
setlocal EnableDelayedExpansion
for /f "tokens=* delims= " %%a in ('echo %NOW%') do (set NOW=%%a & set NOW=!NOW: =!)
endlocal & set DAT=[%DAY%-%NOW%]
set DIRZIP="C:\My Program Files\!sbn.zip\7z.exe"
::-----------------------------------------------

set fn=index

set DES=%fn%-%DAT%.html
copy %fn%.html  "%DES%" /V /Y
