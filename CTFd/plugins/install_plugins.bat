@echo off
echo [*] Début du clonage des plugins...
cd /d "%~dp0"

:: Plugins officiels ou maintenus par la team CTFd
git clone https://github.com/CTFd/ctfd-chall-manager.git
git clone https://github.com/CTFd/DynamicValueChallenge.git
git clone https://github.com/CTFd/ctfd-multi-question-plugin.git
git clone https://github.com/CTFd/ctfd-matrix-scoreboard-plugin.git
git clone https://github.com/CTFd/recaptcha-plugin.git

:: Plugins communautaires
git clone https://github.com/ctfer-io/ctfd-packaged.git
git clone https://github.com/0x4m4/first-strike-alert.git
git clone https://github.com/0x4m4/m0xblood-ctfd-theme.git
git clone https://github.com/degun-osint/bulk_challenge_manager.git
git clone https://github.com/jonscafe/ctfd-gravatar.git
git clone https://github.com/TheFlash2k/CTFd-Wave-Release.git

echo [*] Clonage terminé.

:: Installation des dépendances si fichier requirements.txt présent
for /D %%D in (*) do (
    if exist "%%D\requirements.txt" (
        echo [*] Installation des dépendances pour %%D...
        pip install -r "%%D\requirements.txt"
    )
)

echo [✓] Tous les plugins ont été clonés et les dépendances installées si disponibles.
pause