#disable system protection
disable-computerrestore -drive "C:\"

#turn on Remote Registry
Set-Service -name "Remote Registry" -StartupType Automatic -Status Running

#set power plan to High Performance
Powercfg -SETACTIVE SCHEME_MIN

#disable offline files
Set-Service -name "Offline Files" -StartupType Disabled -Status Stopped

#create C:\Temp
mkdir C:\Temp

#disable firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
