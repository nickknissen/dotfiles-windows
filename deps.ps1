# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}


### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force
Install-Module Get-ChildItemColor -Scope CurrentUser -Force
Install-Module PSFzf -Scope CurrentUser -Force

# Setup scoop
irm get.scoop.sh | iex


# Enable Hyper-V (for WSL)
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Install from ms store
winget install --accept-package-agreements --accept-source-agreements --source msstore "Windows Subsystem for Linux" --id 9P9TQF7MRM4R
winget install --accept-package-agreements --source msstore "Ubuntu 20.04 LTS" --id 9N6SVWS3RX71

# system and cli
winget install Git.Git                                   --silent --accept-package-agreements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
winget install Python.Python.3                           --silent --accept-package-agreements
winget install dotnet-sdk-6 
winget install dotnet-sdk-5

# browsers
winget install Google.Chrome                             --silent --accept-package-agreements


# dev tools and frameworks
winget install Microsoft.PowerShell                      --silent --accept-package-agreements
winget install Microsoft.SQLServer.2019.Developer        --silent --accept-package-agreements
winget install Microsoft.SQLServerManagementStudio       --silent --accept-package-agreements
winget install Microsoft.VisualStudio.2022.Professional  --silent --accept-package-agreements --override "--wait --quiet --norestart --nocache --addProductLang En-us --add Microsoft.VisualStudio.Workload.Azure --add Microsoft.VisualStudio.Workload.NetWeb"
winget install Neovim.Neovim                             --silent --accept-package-agreements
winget install -e --id TablePlus.TablePlus -v 4.8.3
winget install -e --id Microsoft.VisualStudioCode


# Other
winget install --accept-package-agreements --source winget "1Password" --id "AgileBits.1Password"
winget install --accept-package-agreements --source msstore "Spotify Music" --id 9NCBCSZSJRSB
winget install --accept-package-agreements --source msstore "Microsoft PowerToys" --id XP89DCGQ3K6VLD
winget install --accept-package-agreements --source msstore "AutoHotkey Store Edition" --id 9NQ8Q8J78637

Refresh-Environment


### Node Packages
Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
if (which npm) {
    npm update npm
    npm install -g @vue/cli
}
