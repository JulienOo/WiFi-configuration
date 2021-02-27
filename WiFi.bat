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




set /a compteur=0

for %%a in ("WiFi/*.xml") do (
	set /a compteur+=1

	if /i %wifi% EQU %%a (netsh wlan add profile filename="WiFi/"%%a user=all && exit)
	)




netsh wlan add profile filename="WiFi/Formation-Premica.xml" user=all






:ajoutWiFiScript
netsh wlan show profiles > temp.txt




pause
