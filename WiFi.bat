@echo off 
setlocal enabledelayedexpansion 


echo SCRIPT WIFI
:otherChoice
echo * * * * * * * * * * * * *


echo 1 configuration d'un wifi sur l'ordinateur 
echo 2 ajout d'un réseau Wifi sur le SCRIPT
echo 3 fermer le script 
echo.


:returnChoix1
set /p choix= votre choix : 


if %choix% EQU 1 ( goto :configurationWifi )
if %choix% EQU 2 ( goto :ajoutWiFiScript )
if %choix% EQU 3 ( exit )


echo.
echo Merci de choisir une valeur correct
echo.
goto :returnChoix1






:configurationWifi

set /a compteur=0

echo.
echo.
echo Voici les réseaux wifi disponible : 
echo.
for %%a in ("WiFi/*.xml") do (
	set /a compteur+=1
	echo !compteur!  %%a)

:return2
echo.
set /p wifi= Quel wifi ajouter ? 
echo.



if /i %wifi% GTR %compteur% (echo Merci de choisir une valeur correct ! && goto :return2 )




rem set /a compteur=0

rem for %%a in ("WiFi/*.xml") do (
rem 	set /a compteur+=1
rem echo tour !compteur!
rem echo !wifi!

rem 	if /i !wifi! EQU !compteur! (netsh wlan add profile filename="WiFi/"%%a user=all )
rem 	)




rem rem netsh wlan add profile filename="WiFi/Formation-Premica.xml" user=all


rem pause
rem exit



:ajoutWiFiScript
chcp 1252 > NUL
netsh wlan show profiles > temp.txt
chcp 850 > NUL


echo > temp2.txt


more +9 temp.txt > temp2.txt

del temp.txt
ren temp2.txt temp.txt


echo.
echo.
echo Voici les Wifi configuré sur l'ordinateur
echo.

for /f "delims=" %%i in ('type temp.txt') do (
    set var=%%i
    rem chcp 1252
    echo !var:~39! >> temp2.txt

    set /a compteur+=1
	echo !compteur! !var:~39!
    )
	set /a compteur+=1
	echo !compteur! ajouter tous les wifi !

del temp.txt
ren temp2.txt temp.txt

:return3
echo.

set /p ajoutWifi= Quel wifi ajouter ? 




set /a compteur=0
for /f "delims=" %%i in ('type temp.txt') do (
	set /a compteur+=1
    set var=%%i

	if /i !ajoutWifi! EQU !compteur! (cd %~dp0"\Wifi" && netsh wlan export profile !var! key=clear folder=. && goto :cestgood )

    )
	set /a compteur+=1
	if /i !ajoutWifi! EQU !compteur! (cd %~dp0"\Wifi" && netsh wlan export profile key=clear folder=. && goto :cestgood  )


echo.
echo Merci de choisir une valeur correct ! && goto :return3


:cestgood 

pause

