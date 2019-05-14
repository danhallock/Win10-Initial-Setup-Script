##########
# Personal tweak variants for Disassembler's Win10 initial setup script
# Note: since this is for limited distribution, I haven't bothered with
#  the reversal "reinstall bloat" functions. Caveat emptor.
# Author: Dan Hallock <dan@hallock.family>
# Version: 2019-05-13
# Source: 
##########

Function UninstallBloatDRH {
	Write-Output "Uninstalling bloatware:"
    $AppsList = Get-Content "$PSScriptRoot\w10-packages-remove.txt" | Where-Object {-not ($_.StartsWith('#'))} | Where-Object {$_ -ne ""}


    ForEach ($App in $AppsList)
    {
    $PackageFullName = (Get-AppxPackage $App).PackageFullName 
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.DisplayName -eq $App}).PackageName
    if ($PackageFullName) {
    Write-Host "Removing Package: $App"
    Remove-AppxPackage -package $PackageFullName -ErrorAction SilentlyContinue
    }
    if ($ProPackageFullName) {
    Write-Host "Removing Provisioned Package: $ProPackageFullName"
    Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName -ErrorAction SilentlyContinue
    }

    }
}

Function UninstallBloatOneTimeDRH {
    Write-Output "Uninstalling bloatware (one-time only):"
    $AppsList = Get-Content "$PSScriptRoot\w10-packages-remove-firstrunonly.txt" | Where-Object {-not ($_.StartsWith('#'))} | Where-Object {$_ -ne ""}

    ForEach ($App in $AppsList)
    {
    $PackageFullName = (Get-AppxPackage $App).PackageFullName 
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.DisplayName -eq $App}).PackageName
    if ($PackageFullName) {
    Write-Host "Removing Package: $App"
    Remove-AppxPackage -package $PackageFullName -ErrorAction SilentlyContinue
    }
    if ($ProPackageFullName) {
    Write-Host "Removing Provisioned Package: $ProPackageFullName"
    Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName -ErrorAction SilentlyContinue
    }

    }
}