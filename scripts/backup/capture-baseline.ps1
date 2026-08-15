# Core Server Hybrid Windows
# Generic baseline capture script
# Run in an elevated PowerShell session.
#
# IMPORTANT:
#   Set $Root to the correct device/OS-specific destination.
#   Never point Win10 and Win11 at the same directory.

param(
    [Parameter(Mandatory=$true)]
    [string]$Root
)

$Master = Join-Path $Root "MASTER-BACKUP"

$Dirs = @(
    "00-IDENTITY",
    "01-STORAGE",
    "02-PARTITION",
    "03-VOLUME",
    "04-BOOT-EFI",
    "05-POWER",
    "06-SERVICES",
    "07-NETWORK",
    "08-ROUTING"
)

$Dirs | ForEach-Object {
    New-Item -ItemType Directory -Path (Join-Path $Master $_) -Force | Out-Null
}

Get-CimInstance Win32_ComputerSystem |
    Select-Object Manufacturer,Model,SystemType |
    Out-File (Join-Path $Master "00-IDENTITY\computer-system.txt")

Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption,Version,BuildNumber,SystemDrive,WindowsDirectory,LastBootUpTime |
    Out-File (Join-Path $Master "00-IDENTITY\operating-system.txt")

Get-CimInstance Win32_BIOS |
    Select-Object Manufacturer,SMBIOSBIOSVersion,SerialNumber,ReleaseDate |
    Out-File (Join-Path $Master "00-IDENTITY\bios.txt")

Get-Disk |
    Sort-Object Number |
    Select-Object Number,FriendlyName,SerialNumber,BusType,PartitionStyle,OperationalStatus,HealthStatus,Size |
    Format-List |
    Out-File (Join-Path $Master "01-STORAGE\physical-disks.txt")

Get-Partition |
    Sort-Object DiskNumber,PartitionNumber |
    Select-Object DiskNumber,PartitionNumber,DriveLetter,Type,GptType,Size,Offset |
    Format-List |
    Out-File (Join-Path $Master "02-PARTITION\partitions.txt")

Get-Volume |
    Sort-Object DriveLetter |
    Select-Object DriveLetter,FileSystemLabel,FileSystem,HealthStatus,Size,SizeRemaining |
    Format-List |
    Out-File (Join-Path $Master "03-VOLUME\volumes.txt")

Get-Partition |
    Where-Object {
        $_.Type -match "System|Reserved|Recovery" -or
        $_.GptType -match "C12A7328|E3C9E316|DE94BBA4"
    } |
    Sort-Object DiskNumber,PartitionNumber |
    Select-Object DiskNumber,PartitionNumber,DriveLetter,Type,GptType,Size |
    Format-List |
    Out-File (Join-Path $Master "04-BOOT-EFI\boot-partitions.txt")

bcdedit /enum all |
    Out-File (Join-Path $Master "04-BOOT-EFI\bcdedit.txt")

powercfg /getactivescheme |
    Out-File (Join-Path $Master "05-POWER\active-power-plan.txt")

powercfg /list |
    Out-File (Join-Path $Master "05-POWER\power-plans.txt")

powercfg /query SCHEME_CURRENT SUB_BUTTONS |
    Out-File (Join-Path $Master "05-POWER\power-buttons-and-lid.txt")

powercfg /query SCHEME_CURRENT SUB_SLEEP |
    Out-File (Join-Path $Master "05-POWER\sleep.txt")

powercfg /a |
    Out-File (Join-Path $Master "05-POWER\available-sleep-states.txt")

Get-Service |
    Sort-Object Name |
    Select-Object Name,DisplayName,Status,StartType |
    Export-Csv (Join-Path $Master "06-SERVICES\all-services.csv") -NoTypeInformation

Get-NetAdapter |
    Sort-Object ifIndex |
    Select-Object ifIndex,Name,InterfaceDescription,Status,LinkSpeed,MacAddress |
    Format-List |
    Out-File (Join-Path $Master "07-NETWORK\network-adapters.txt")

Get-NetConnectionProfile |
    Select-Object Name,InterfaceAlias,InterfaceIndex,NetworkCategory,IPv4Connectivity,IPv6Connectivity |
    Format-List |
    Out-File (Join-Path $Master "07-NETWORK\network-profiles.txt")

Get-NetIPConfiguration |
    Where-Object {
        $_.IPv4Address -and
        $_.InterfaceAlias -notmatch "Loopback|vEthernet"
    } |
    Format-List |
    Out-File (Join-Path $Master "07-NETWORK\ip-configuration.txt")

Get-NetIPInterface -AddressFamily IPv4 |
    Sort-Object InterfaceIndex |
    Select-Object InterfaceAlias,InterfaceIndex,Dhcp,ConnectionState,AutomaticMetric,InterfaceMetric |
    Format-List |
    Out-File (Join-Path $Master "07-NETWORK\ip-interface-metrics.txt")

Get-NetRoute -AddressFamily IPv4 |
    Where-Object {$_.State -eq "Alive"} |
    Sort-Object DestinationPrefix,RouteMetric |
    Select-Object InterfaceAlias,DestinationPrefix,NextHop,RouteMetric,State |
    Format-List |
    Out-File (Join-Path $Master "08-ROUTING\ipv4-routes.txt")

Get-NetRoute -AddressFamily IPv4 |
    Where-Object {$_.DestinationPrefix -eq "0.0.0.0/0"} |
    Sort-Object InterfaceMetric |
    Select-Object InterfaceAlias,InterfaceIndex,DestinationPrefix,NextHop,RouteMetric,InterfaceMetric |
    Format-List |
    Out-File (Join-Path $Master "08-ROUTING\default-routes.txt")

Write-Host "Baseline capture complete: $Master" -ForegroundColor Green
