### incomplete ###

#disable offline files
Set-Service -name "Offline Files" -StartupType Disabled -Status Stopped

#disable system protection
disable-computerrestore -drive "C:\"

#turn on Remote Registry
Set-Service -name "Remote Registry" -StartupType Automatic -Status Running

#set power plan to High Performance
Powercfg -SETACTIVE SCHEME_MIN

#create C:\Temp
mkdir C:\Temp

#disable firewall
netsh advfirewall set allprofiles state off

#enable administrator account
$AdminPass = Read-Host -Prompt 'Please enter the local admin password'
net user administrator $AdminPass /active

#set mystify screensaver
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d C:\Windows\system32\Mystify.scr /f

#set screensaver timeout to 30 minutes
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveTimeOut /t REG_SZ /d 1800 /f
