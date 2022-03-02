@echo off 
setlocal enabledelayedexpansion 

REM vérification présence repertoire Wifi
if not exist "./WiFi" ( mkdir WiFi )
:startApp
REM vide le contenu de l'affichage
cls
REM actualise le repertoire
cd %~dp0
echo SCRIPT WIFI
:otherChoice
echo * * * * * * * * * * * * *

chcp 65001 > NUL
echo 1 - configuration d'un wifi sur l'ordinateur 
echo 2 - ajout d'un réseau Wifi sur le SCRIPT
echo 3 - fermer le script 
echo.


:retourChoix1
set /p choix= votre choix : 


if %choix% EQU 1 ( goto :configurationWifi )
if %choix% EQU 2 ( goto :ajoutWiFiScript )
if %choix% EQU 3 ( goto :closeApp )


echo.
echo Merci de choisir une valeur correct
echo.
goto :retourChoix1






:configurationWifi

set /a compteur=0

echo.
echo.
echo Voici les réseaux wifi disponible : 
echo.
for %%a in ("WiFi/*.xml") do (
	set /a compteur+=1
	echo !compteur! - %%a)


if /i !compteur! EQU 0 (
	echo Le script ne connait aucun WiFi à intégrer à l'ordinateur !
	echo.
) 
	if /i !compteur! NEQ 0 (
	:return2
	echo.
	set /p wifi= Quel wifi ajouter ? 
	echo.
	if /i !wifi! GTR !compteur! (echo Merci de choisir une valeur correct 1 && goto :return2 )
	if /i !wifi! LSS 1 (echo Merci de choisir une valeur correct ! 2 && goto :return2 )
)



set /a compteur=0

for %%a in ("WiFi/*.xml") do (
	set /a compteur+=1

	if /i !wifi! EQU !compteur! (netsh wlan add profile filename="WiFi/"%%a user=all )
)

pause
goto :startApp


rem rem netsh wlan add profile filename="WiFi/Formation-Premica.xml" user=all


rem pause
rem exit



:ajoutWiFiScript
netsh wlan show profiles > temp.txt


echo > temp2.txt


more +9 temp.txt > temp2.txt

del temp.txt
ren temp2.txt temp.txt


echo.
echo.
echo Voici les Wifi configuré sur l'ordinateur
echo.

set /a compteur=0
for /f "delims=" %%i in ('type temp.txt') do (
    set var=%%i
    rem chcp 1252
    echo !var:~39! >> temp2.txt

    set /a compteur+=1
	echo !compteur! - !var:~39!
    )
	set /a compteur+=1
	echo !compteur! - ajouter tous les wifi !


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
goto :startApp


:closeApp
cd %~dp0
if exist "temp.txt" ( del "temp.txt" )