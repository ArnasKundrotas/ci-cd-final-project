Write-Host "**************************************************"
Write-Host " Setting up CI/CD Final Project Environment"
Write-Host "**************************************************"

Write-Host "*** Installing Python 3.9 and Virtual Environment"
# Update and install Python 3.9 via Chocolatey (or adjust to your package manager)
choco install python --version=3.9 -y

Write-Host "*** Making Python 3.9 the default..."
# Ensure the correct Python version is used
$env:Path = "C:\Python39;C:\Python39\Scripts;$env:Path"

Write-Host "*** Checking the Python version..."
python --version

Write-Host "*** Creating a Python virtual environment"
python -m venv $HOME\venv

Write-Host "*** Configuring the developer environment..."
# Adding environment variables and virtual environment activation to PowerShell profile
$profilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if (!(Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}
Add-Content -Path $profilePath -Value "`n# CI/CD Final Project additions"
Add-Content -Path $profilePath -Value "Set-Variable -Name GITHUB_ACCOUNT -Value $env:GITHUB_ACCOUNT"
Add-Content -Path $profilePath -Value "Set-Alias python3 python"
Add-Content -Path $profilePath -Value "$HOME\venv\Scripts\Activate.ps1"

Write-Host "*** Installing Selenium and Chrome for BDD"
# Install ChromeDriver and Selenium dependencies
choco install chromedriver -y
pip install selenium

Write-Host "*** Installing Python dependencies..."
# Activate the virtual environment and install dependencies
& $HOME\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

Write-Host "**************************************************"
Write-Host " CI/CD Final Project Environment Setup Complete"
Write-Host "**************************************************"
Write-Host ""
Write-Host "Use 'exit' to close this terminal and open a new one to initialize the environment"
Write-Host ""