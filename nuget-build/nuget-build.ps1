$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
Write-Output "Downloading nuget.exe"
Invoke-WebRequest "https://nuget.org/nuget.exe" -OutFile $root\Nuget.exe

[String]$buildver = $Env:BUILD_BUILDNUMBER
Write-Host "buildver is $buildver"

$version = [System.Reflection.Assembly]::LoadFile("$root\[RELATIVE_TARGET_RELEASE_DLL]").GetName().Version
$versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $buildver)
Write-Host "Setting .nuspec version tag to $versionStr"
$content = (Get-Content $root\nuget\[PROJECT_NAME].nuspec)
$content = $content -replace '\$version\$',$versionStr

$content | Out-File $root\nuget\[PROJECT_NAME].nuspec


Write-Output "Creating Nuget Package"
& $root\Nuget.exe pack $root\nuget\[PROJECT_NAME].nuspec