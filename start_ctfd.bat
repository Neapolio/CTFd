@echo off
REM Lancement de CTFd en local

cd /d %~dp0

echo [*] Activation de l'environnement virtuel...
call venv\Scripts\activate

echo [*] Démarrage de CTFd...
flask run --host=127.0.0.1 --port=4000

pause