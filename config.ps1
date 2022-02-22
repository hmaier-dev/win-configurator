Write-Host "-------------------------------------------"
Write-Host "Run this script as Administrator!"
Write-Host "-------------------------------------------"

function is_admin
{
	$user = [Security.Principal.WindowsIdentity]::GetCurrent();
	$elevated = ([System.Security.Principal.WindowsPrincipal]([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole] "Administrator");
	if (-Not ($elevated))
	{
		Write-Warning "Please run this script as an administrator";
		Break;
	}
}
# calling is_admin
is_admin

# Installing the scoop package manager
Write-Host "Downloading and installing the 'scoop' package-manager..." 
iwr -useb get.scoop.sh | iex

Write-Host "Installing neovim..."
scoop install neovim

Write-Host "Downloading vim-plug..."
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim" -Force

Write-Host "Downloading init.vim..."
iwr -useb https://raw.githubusercontent.com/hmaier-ipb/dotfiles/main/.config/nvim/init.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/init.vim" -Force

Write-Host "Installing all plugins from init.vim..."
nvim.exe -Es -c ":PlugInstall" -c ":qa!"


