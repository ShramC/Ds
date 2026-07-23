# ╔══════════════════════════════════════════════════════════╗
# ║           Minecraft Cheat Loader & Menu                  ║
# ╚══════════════════════════════════════════════════════════╝

$ProgressPreference = 'SilentlyContinue'
[System.Net.ServicePointManager]::SecurityProtocol = 3072

Write-Host @"
████  █████ █     ███ █████  ███      ███  █   █ █████ ███       ███  █   █ ███ █████ 
█   █ █     █      █    █   █   █    █   █ ██  █   █    █       █     █   █  █    █   
█   █ ████  █      █    █   █████    █████ █ █ █   █    █  ████ █     █████  █    █   
█   █ █     █      █    █   █   █    █   █ █  ██   █    █       █     █   █  █    █   
████  █████ █████ ███   █   █   █    █   █ █   █   █   ███       ███  █   █ ███   █   
"@ -ForegroundColor Green

Write-Host "`n[1] Скачать и запустить loder.ps1" -ForegroundColor Cyan
Write-Host "[2] Проверить наличие читов в папке Minecraft" -ForegroundColor Cyan
Write-Host "[3] Выход`n" -ForegroundColor Cyan

do {
    $choice = Read-Host "Введите номер действия"
    switch ($choice) {
        '1' {
            Write-Host "`nСкачивание loder.ps1..." -ForegroundColor Yellow
            $url = "https://github.com/ShramC/Ds/raw/refs/heads/main/loder.ps1"
            $out = "$env:TEMP\loder.ps1"
            try {
                Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop
                Write-Host "Скачано: $out" -ForegroundColor Green
                Write-Host "Запуск loder.ps1..." -ForegroundColor Yellow
                powershell.exe -NoProfile -ExecutionPolicy Bypass -File $out
                Write-Host "loder.ps1 завершил работу." -ForegroundColor Green
            } catch {
                Write-Host "Ошибка скачивания: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        '2' {
            Write-Host "`nПроверка папки Minecraft на наличие читов..." -ForegroundColor Yellow
            $mcPaths = @(
                "$env:APPDATA\.minecraft",
                "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
            )
            $found = $false
            foreach ($path in $mcPaths) {
                if (Test-Path $path) {
                    Write-Host "Найдена папка Minecraft: $path" -ForegroundColor Green
                    Get-ChildItem -Path $path -Recurse -File -Include "*.jar","*.dll","*.exe" -ErrorAction SilentlyContinue |
                        Where-Object { $_.Name -match "(?i)(cheat|чит|hack|чит|mod|мод)" } |
                        ForEach-Object {
                            Write-Host "  [ЧИТ НАЙДЕН] $($_.FullName)" -ForegroundColor Red
                            $found = $true
                        }
                }
            }
            if (-not $found) {
                Write-Host "Читы не обнаружены." -ForegroundColor Green
            }
        }
        '3' {
            Write-Host "`nВыход..." -ForegroundColor Yellow
            exit 0
        }
        default {
            Write-Host "Неверный выбор. Попробуйте снова." -ForegroundColor Red
        }
    }
    Write-Host "`nНажмите Enter для возврата в меню..." -ForegroundColor DarkGray
    Read-Host
    Clear-Host
    Write-Host @"
████  █████ █     ███ █████  ███      ███  █   █ █████ ███       ███  █   █ ███ █████ 
█   █ █     █      █    █   █   █    █   █ ██  █   █    █       █     █   █  █    █   
█   █ ████  █      █    █   █████    █████ █ █ █   █    █  ████ █     █████  █    █   
█   █ █     █      █    █   █   █    █   █ █  ██   █    █       █     █   █  █    █   
████  █████ █████ ███   █   █   █    █   █ █   █   █   ███       ███  █   █ ███   █   
"@ -ForegroundColor Green
    Write-Host "`n[1] Скачать и запустить loder.ps1" -ForegroundColor Cyan
    Write-Host "[2] Проверить наличие читов в папке Minecraft" -ForegroundColor Cyan
    Write-Host "[3] Выход`n" -ForegroundColor Cyan
} while ($true)
