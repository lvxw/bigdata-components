@echo off
echo "Silently installing IntelliJ IDEA 2025.3.3..."
if not exist "C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.3\bin\idea64.exe" (
    "C:\Users\docker\Desktop\Shared\idea-2025.3.3.exe" /S
    echo "Installation IntelliJ IDEA 2025.3.3 complete."
) else (
    echo "IDEA 2025.3.3 already exists, skip install"
)

if not exist "C:\Program\Common7\IDE\devenv.exe" (
    echo "installing Visual Studio"
    powershell -Command "& {Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vs_community.exe' -OutFile $env:TEMP\\vs_community.exe; Start-Process -FilePath $env:TEMP\\vs_community.exe -ArgumentList '--installPath', 'C:\\Program Files\\Microsoft Visual Studio\\2026', '--add', 'Microsoft.VisualStudio.Workload.ManagedDesktop', '--includeRecommended', '--quiet', '--wait' -Wait -PassThru}"
    echo "Installation Visual Studio complete."
) else (
    echo "Visual Studio already exists, skip install"
)

if not exist "C:\Program Files\Git\bin\git.exe" (
    echo "installing Git"
    "C:\Users\docker\Desktop\Shared\Git-2.53.0-64-bit.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /DIR="C:\Program Files\Git"
    echo "Installation Git complete."
) else (
    echo "Git already exists, skip install"
)

if not exist "C:\Users\docker\.local\bin\claude.exe" (
    echo "installing claude code"
    powershell -ExecutionPolicy Bypass -File "C:\Users\docker\Desktop\Shared\install.ps1"
    powershell -Command "[Environment]::SetEnvironmentVariable(\"Path\", \"C:\Users\docker\.local\bin;$([Environment]::GetEnvironmentVariable('Path', 'User'))\", \"User\")"
    powershell -Command "$lines=[System.Collections.ArrayList](gc 'C:\Users\docker\.claude.json');$lines.Insert([Math]::Max(0,$lines.Count-1),',\"hasCompletedOnboarding\": true');$lines|sc 'C:\Users\docker\.claude.json'"
    echo "Installation claude code complete."
) else (
    echo "Claude Code already exists, skip install"
)
pause