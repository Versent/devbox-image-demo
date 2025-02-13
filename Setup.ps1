. $PSScriptRoot\functions.ps1

try
{
    Write-Host "Checking for PowerShell Core..."

    pwsh -v

    Write-Host "PowerShell Core is installed."
}
catch
{
    Write-Host "PowerShell Core is not installed. Installing ..."
    Start-WithStatus "Installing PowerShell Core" {
        # Get the latest download URL
        $URL = Invoke-RestMethod -Uri "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $URL = $URL.assets.browser_download_url -match 'win-x64.msi'

        Write-Output "Downloading $URL ..."

        # Define the destination
        $destination = "$env:TEMP\\PowerShell-latest.msi"

        Invoke-WebRequest -Uri "$URL" -OutFile $destination

        Start-Process -FilePath msiexec.exe -ArgumentList "/i $destination /qn /norestart" -Wait -NoNewWindow

        Remove-Item $destination
    }
}

try
{
    Write-Host "Checking for Winget..."

    winget --version

    Write-Host "Winget is installed."
}
catch
{
    Write-Host "Winget is not installed."
}

