@echo off
::color 0A


set cc=QPCore

echo %cc%

sc stop "%cc%"
sc config "%cc%" start= disabled
sc delete "%cc%"
