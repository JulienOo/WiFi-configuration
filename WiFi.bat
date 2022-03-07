@echo off 

REM ###########################################################


REM version : 1.0.0.1

REM github : https://github.com/JulienOo/WiFi-configuration


REM ###########################################################


REM modification gestion variables
setlocal enabledelayedexpansion 

REM vérification présence repertoire Wifi
if not exist "./WiFi" ( mkdir WiFi )

REM recherche si un fichier temporaire existe déjà
if exist "temp.txt" ( del "temp.txt" )

:startApp

REM vide le contenu de l'affichage
cls


REM actualise le repertoire
cd %~dp0


echo SCRIPT Wi-Fi
:otherChoice
echo.
echo.
echo * * * * * * * * * * * * *
echo.

REM chcp 1252 > NUL
echo 1 - ajout d'un réseau Wifi sur le SCRIPT
echo 2 - configuration d'un wifi sur l'ordinateur 
echo 3 - fermer le script 
echo.


:retourChoix1
set /p choix= votre choix : 

if /i !choix! EQU 1 ( goto :ajoutWiFiScript )
if /i !choix! EQU 2 ( goto :configurationWifi )
if /i !choix! EQU 3 ( goto :closeApp )


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
echo.
echo !compteur! - ajouter tous les wifi 
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
	if /i !wifi! GTR !compteur! (echo Merci de choisir une valeur correct ! && goto :return2 )
	if /i !wifi! LSS 0 (echo Merci de choisir une valeur correct ! && goto :return2 )
)



set /a compteur=0

for %%a in ("WiFi/*.xml") do (
	set /a compteur+=1

	if /i !wifi! EQU !compteur! (netsh wlan add profile filename="WiFi/%%a" user=all )
	if /i !wifi! EQU 0 (netsh wlan add profile filename="WiFi/%%a" user=all )
)
echo.
pause
goto :startApp




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
echo.
set /a compteur=0


echo.


for /f "delims=" %%i in ('type temp.txt') do (
    set var=%%i

     if /i !compteur! EQU 0 ( echo !compteur! - ajouter tous les wifi ! && echo. )

    echo !var:~39! >> temp2.txt

    set /a compteur+=1
	echo !compteur! - !var:~39!
    )
	set /a compteur+=1
	

del temp.txt
ren temp2.txt temp.txt

:return3
echo.

set /p ajoutWifi= Quel wifi ajouter ? 




set /a compteur=1

if /i !ajoutWifi! EQU 0 (cd "%~dp0"\WiFi && netsh wlan export profile key=clear folder=. && goto :cestgood  )
for /f "delims=" %%i in ('type temp.txt') do (
    set var=%%i
	echo %%i
	echo !compteur!
	if /i !ajoutWifi! EQU !compteur! (cd "%~dp0\Wifi" && netsh wlan export profile !var! key=clear folder=. && goto :cestgood )
	set /a compteur+=1
    )

	set /a compteur+=1

echo.
echo Merci de choisir une valeur correct ! && goto :return3



:cestgood 

pause
goto :startApp


:closeApp
cd %~dp0
if exist "temp.txt" ( del "temp.txt" )