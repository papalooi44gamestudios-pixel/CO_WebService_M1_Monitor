$taskName = "CO_WebService_M1_Watchdog"
$scriptPath = "C:\Scripts\Check-CO_WebService_M1.ps1"
$folder = "C:\Scripts"

# 1. Ordner sicherstellen
if (!(Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
}

# 2. Script erstellen (falls noch nicht vorhanden)
if (!(Test-Path $scriptPath)) {
    Write-Host "Lege Watchdog Script an..."
    # Hier müsstest du den Inhalt aus Script 1 einfügen oder vorher separat kopieren
}

# 3. Action
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`""

# 4. Trigger (alle 4 Stunden ab 01:00)
$trigger = New-ScheduledTaskTrigger -Daily -At 01:00
$trigger.RepetitionInterval = (New-TimeSpan -Hours 4)
$trigger.RepetitionDuration = (New-TimeSpan -Days 1)

# 5. Settings (Hardening)
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RestartCount 999 `
    -RestartInterval (New-TimeSpan -Minutes 1)

# 6. Principal (SYSTEM)
$principal = New-ScheduledTaskPrincipal `
    -UserId "SYSTEM" `
    -LogonType ServiceAccount `
    -RunLevel Highest

# 7. Task erstellen
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Principal $principal `
    -Force

Write-Host "Watchdog Task erfolgreich installiert."