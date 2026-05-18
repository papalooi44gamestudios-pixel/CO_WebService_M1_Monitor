$serviceName = "CO_WebService_M1"
$logFile = "C:\Scripts\CO_WebService_M1_watchdog.log"

function Log($msg) {
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$time $msg"
}

try {
    $service = Get-Service -Name $serviceName -ErrorAction Stop

    if ($service.Status -ne "Running") {
        Log "Service STOPPED -> starte Service"

        Start-Service -Name $serviceName -ErrorAction Stop

        # robustes Polling statt Refresh()
        $timeout = 30
        $elapsed = 0

        do {
            Start-Sleep -Seconds 2
            $service = Get-Service -Name $serviceName
            $elapsed += 2
        } while ($service.Status -ne "Running" -and $elapsed -lt $timeout)

        if ($service.Status -eq "Running") {
            Log "Service läuft nach $elapsed Sekunden"
        } else {
            Log "FEHLER: Service startet nicht korrekt. Status: $($service.Status)"
        }
    }
    else {
        Log "Service läuft OK"
    }
}
catch {
    Log "EXCEPTION: $($_.Exception.Message)"
    exit 1
}