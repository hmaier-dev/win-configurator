
Write-Host "-------------------------------------------"
Write-Host "Run this script as Administrator!"
Write-Host "-------------------------------------------"


# Installing the scoop package manager
Write-Host "Downloading and installing the 'scoop' package-manager..." 
wr -useb get.scoop.sh | iex

Write-Host "Installing neovim..."
scoop install nvim

Write-Host "Downloading vim-plug..."
wr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim" -Force
