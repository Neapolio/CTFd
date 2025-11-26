# install_plugins.ps1
$ErrorActionPreference = "Stop"

$PLUGINS = @{
    "https://github.com/ctfer-io/ctfd-packaged.git"        = "ctfd-packaged"
    "https://github.com/0x4m4/first-strike-alert.git"       = "first-strike-alert"
    "https://github.com/0x4m4/m0xblood-ctfd-theme.git"      = "m0xblood-ctfd-theme"
    "https://github.com/degun-osint/bulk_challenge_manager.git" = "bulk_challenge_manager"
    "https://github.com/jonscafe/ctfd-gravatar.git"         = "ctfd-gravatar"
    "https://github.com/TheFlash2k/CTFd-Wave-Release.git"   = "CTFd-Wave-Release"
}

$pluginPath = "CTFd\plugins"
if (-not (Test-Path $pluginPath)) {
    Write-Host "Chemin $pluginPath introuvable. Ce script doit être exécuté depuis la racine du projet CTFd." -ForegroundColor Red
    exit 1
}

foreach ($repo in $PLUGINS.Keys) {
    $folder = Join-Path $pluginPath $PLUGINS[$repo]

    if (Test-Path $folder) {
        Write-Host "Le plugin '$($PLUGINS[$repo])' existe déjà. Skip..." -ForegroundColor Yellow
    } else {
        git clone $repo $folder
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Erreur lors du clonage de $repo" -ForegroundColor Red
            continue
        }
        Write-Host "Cloné : $repo" -ForegroundColor Green
    }

    $initPath = Join-Path $folder "__init__.py"
    if (-not (Test-Path $initPath)) {
        New-Item -Path $initPath -ItemType File -Force | Out-Null
        Write-Host "Ajout de __init__.py dans $($PLUGINS[$repo])"
    }

    $initContent = Get-Content $initPath
    if (-not ($initContent -match "def\s+load")) {
        Add-Content $initPath "`n`ndef load(app):`n    pass"
        Write-Host "Ajout d'une fonction load(app) vide dans $($PLUGINS[$repo])"
    }
}
