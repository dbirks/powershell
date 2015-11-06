<#
Turns on system protection, sets max usage size, schedules the first shadow backup.
Accepts a parameter for Max Usage size.
Default Max Usage size is 10%.

Examples:
.\Schedule-Shadow-Copies.ps1
or
.\Schedule-Shadow-Copies.ps1 15GB
or
.\Schedule-Shadow-Copies.ps1 5%
#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$False,Position=1)]
        [string]$size="10%"
)

Enable-ComputerRestore -Drive "c:\"

#set size (default 10%)
vssadmin resize shadowstorage /for=c: /on=c: /maxsize=$size

#make a restore point
#(it will wait for the computer to be inactive for 10 minutes)
schtasks /run /tn "Microsoft\Windows\SystemRestore\SR"
