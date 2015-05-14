# Powershell 2.0

# Stop and fail script when a command fails.
$errorActionPreference = "Stop"

# load library functions
$rsLibDstDirPath = "$env:rs_sandbox_home\RightScript\lib"
. "$rsLibDstDirPath\tools\PsOutput.ps1"
. "$rsLibDstDirPath\tools\ResolveError.ps1"
. "$rsLibDstDirPath\win\Version.ps1"

try
{
    # detects if server OS is 64Bit or 32Bit 
    # Details http://msdn.microsoft.com/en-us/library/system.intptr.size.aspx
    if (Is32bit)
    {                        
        Write-Host "32 bit operating system"   
        $MVC4_path = join-path $env:programfiles "ASP.NET MVC 4"
    } 
    else
    {                        
        Write-Host "64 bit operating system"     
        $MVC4_path = join-path ${env:programfiles(x86)} "ASP.NET MVC 4"
    }

    if (test-path $MVC4_path)
    {
        Write-Output "MVC4 already installed. Skipping installation."
        exit 0
    }

    Write-Host "Installing MVC4 to $MVC4_path"

    $MVC4_binary = "AspNetMVC4Setup.exe"
    cd "$env:RS_ATTACH_DIR"
    cmd /c $MVC4_binary /S

}
catch
{
    ResolveError
    exit 1
}
