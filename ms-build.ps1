# C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe
$DevenvExe = '[VS_RELATIVE_LOCATION]\devenv.exe'
# C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin
$MsBuildExe = '[MSBUILVERSION_RELATIVE_LOCATION]\msbuild.exe'
$SolutionPath = ".\[SOME_SOLUTION_NAME].sln"

& $DevenvExe $SolutionPath /upgrade
& $MsBuildExe $SolutionPath /nologo /nr:false /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:publishUrl="..\WebAppContent\\" /p:platform="any cpu" /p:configuration="release" /p:VisualStudioVersion="15.0"