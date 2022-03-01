
if (Test-Path "C:\Users\Suporte\.jabba\jabba.ps1") { . "C:\Users\Suporte\.jabba\jabba.ps1" }
# Jabba config - JVM

$currentUser= [Security.Principal.WindowsIdentity]::GetCurrent().name;
$currentFolder= Split-Path -Path $pwd -Leaf
$psVersionMajor= $host.Version.Major # PowerShell Version
$psVersionMinor= $host.Version.Minor # PowerShell Version Patch

function prompt { 
  # Show "$currentUser in ../$currentFolder"
  Write-host $currentUser -ForegroundColor Cyan -NoNewline
  Write-host " in " -ForegroundColor White -NoNewline
  Write-host "../$currentFolder" -ForegroundColor Green
  "$psVersionMajor.$psVersionMinor > "
  }
# Promp: $VERSION + " > "
