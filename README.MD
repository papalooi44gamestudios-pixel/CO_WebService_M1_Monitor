CO_WebService_M1 Watchdog

Dieses Projekt stellt einen automatisierten Windows Watchdog bereit, der den Windows Service CO_WebService_M1 in regelmäßigen Intervallen überwacht und bei Bedarf automatisch neu startet.

📌 Zweck

Der Watchdog stellt sicher, dass der Service:

immer läuft
automatisch neu gestartet wird, wenn er gestoppt ist
nach Server-Neustarts automatisch wieder überwacht wird
robust gegen Startverzögerungen oder Hänger ist
🧩 Architektur

Das System besteht aus:

PowerShell Watchdog Script
prüft Service Status
startet Service bei Bedarf
schreibt Log-Dateien
enthält Polling-Mechanismus für sicheren Start
Windows Task Scheduler Job
führt Script regelmäßig aus
läuft unter SYSTEM Account
startet automatisch nach Reboot
arbeitet ohne Benutzeranmeldung
📁 Dateien
Datei	Beschreibung
C:\Scripts\Check-CO_WebService_M1.ps1	Watchdog Script
Install-Watchdog.ps1	Installer für Task Scheduler
C:\Scripts\CO_WebService_M1_watchdog.log	Log-Datei
⚙️ Installation
1. Installer ausführen

PowerShell als Administrator starten:

powershell -ExecutionPolicy Bypass -File .\Install-Watchdog.ps1
2. Ergebnis

Nach der Installation wird automatisch erstellt:

Scheduled Task: CO_WebService_M1_Watchdog
Ausführung alle 4 Stunden:
01:00
05:00
09:00
13:00
17:00
21:00
🔐 Rechte

Der Task läuft unter:

NT AUTHORITY\SYSTEM
mit höchsten Privilegien
🧠 Funktionsweise

Der Watchdog:

prüft Status des Services CO_WebService_M1
wenn Stopped → startet Service
wartet aktiv bis Status Running oder Timeout erreicht ist
schreibt Ergebnis in Log-Datei
🪵 Logging

Log-Datei:

C:\Scripts\CO_WebService_M1_watchdog.log

Beispiel:

2026-05-18 01:00:01 Service STOPPED -> starte Service
2026-05-18 01:00:06 Service läuft nach 5 Sekunden
2026-05-18 05:00:01 Service läuft OK
🛡️ Zuverlässigkeit

Das System ist ausgelegt für:

Windows Server Betrieb
Reboot-resistente Ausführung
fehlertolerante Serviceüberwachung
automatische Wiederherstellung
🔧 Erweiterungsmöglichkeiten

Optional erweiterbar um:

Event Log Integration
Email / SMTP Alerts
Microsoft Teams / Slack Notifications
Force-Restart bei „stuck services“
Monitoring Dashboard Integration
⚠️ Hinweise
Service Name muss exakt stimmen: CO_WebService_M1
Script muss mit Administratorrechten installiert werden
Task Scheduler darf nicht durch GPO blockiert sein
📄 Lizenz

Internes Tool / Projektabhängig (anpassbar)