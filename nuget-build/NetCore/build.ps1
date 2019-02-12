$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
$config = (&{If($Env:BuildConfiguration) {$Env:BuildConfiguration} Else {"Debug"}})

[String]$buildver = (&{If($Env:BUILD_BUILDNUMBER) {$Env:BUILD_BUILDNUMBER} Else {0}})
# use the line below to publish a beta version
# $buildver = "{0}-{1}" -f ($buildver, 'beta')
Write-Host "buildver is $buildver"

$version = [System.Reflection.Assembly]::LoadFile("$root\[RELATIVE_LIB_DIR]\bin\$config\[TARGET_FRAMEWORK]\[DLL_NAME]").GetName().Version
$versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $buildver)
Write-Host "Setting .nuspec version tag to $versionStr"

Write-Output "Creating Nuget Package"
& dotnet pack -c $config /p:PackageVersion=$versionStr -o $root

Exit