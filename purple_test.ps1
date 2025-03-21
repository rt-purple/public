# 1. Création d’un fichier suspect
# Chemin du fichier à créer
$scriptPath = "$env:TEMP\purple_test2.ps1"

# Contenu du script à écrire dans le fichier
$popupScript = @"
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show('Tests')
"@

# Écriture du contenu dans le fichier
Set-Content -Path $scriptPath -Value $popupScript -Force

# Affiche le chemin du script créé
Write-Host "Script créé : $scriptPath"

# 2. Création d’un schedule task (souvent utilisé par des malwares)
$scriptPath = "$env:TEMP\purple_test.ps1"
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 10:00am
$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
Register-ScheduledTask -TaskName "PurpleTests Tasks" -Action $taskAction -Trigger $taskTrigger

# 3. Suppression des logs PowerShell (tentative d’évasion) avec obfuscation de la commande
$command = 'Remove-Item -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue'
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell.exe -EncodedCommand $encodedCommand
