$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
$config = (&{If($Env:BuildConfiguration) {$Env:BuildConfiguration} Else {"Debug"}})
Write-Output "Downloading nuget.exe"
Invoke-WebRequest "https://nuget.org/nuget.exe" -OutFile $root\Nuget.exe

[String]$buildver = (&{If($Env:BUILD_BUILDNUMBER) {$Env:BUILD_BUILDNUMBER} Else {0}})
Write-Host "buildver is $buildver"

$version = [System.Reflection.Assembly]::LoadFile("$root\[RELATIVE_LIB_DIR]\$config\[TARGET_FRAMEWORK]\[DLL_NAME]").GetName().Version
$versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $buildver)
Write-Host "Setting .nuspec version tag to $versionStr"
$content = (Get-Content $root\nuget\[PROJECT_NAME].nuspec)
$content = $content -replace '\$version\$',$versionStr
$content = $content -replace '\$buildConfiguration\$',$config

$content | Out-File $root\nuget\[PROJECT_NAME].$config.nuspec


Write-Output "Creating Nuget Package"
& $root\Nuget.exe pack $root\nuget\[PROJECT_NAME].$config.nuspec