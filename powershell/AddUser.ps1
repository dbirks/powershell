<#
    Example usage:
    AddUser.ps1 -file "New User.xlsm" -password Password123 -domain talkinghippos.com
#> 

# Parameter list
Param(
    [string]$file   # the Excel file to import
    [string]$password # the password for the new user
    [string]$domain # the domain name of the new user
)

# Uncomment to test
$file = 'C:\$HOME\Desktop\New Account Form.xlsm'

# A function to hopefully get the username from any name given to it
function getUsername ($input) {
    if ($foundUser -match "^[a-zA-Z]"){ # if the username isn't empty basically
    # returns smithjo if $input is "smithjo"
    $foundUser = Get-ADUser -Filter {samaccountname -like $input} | Select-Object -ExpandProperty samaccountname
    } elseif ($foundUser -match "^[a-zA-Z]") {
    # returns smithjo if $input is "John Smith"
    $foundUser = Get-ADUser -Filter {name -like $input} | Select-Object -ExpandProperty samaccountname
    } elseif ($foundUser -match "^[a-zA-Z]"){
    # returns smithjo if $input is "John Smi"
    $inputWithWildcards = "*" + $input + "*"
    $foundUser = Get-ADUser -Filter {name -like $inputWithWildcards} | Select-Object -ExpandProperty samaccountname
    } elseif ($foundUser -match "^[a-zA-Z]") {
    # returns smithjo if $input is "Smith, John"
    $foundUser = Get-ADUser -Filter {displayname -like $input} | Select-Object -ExpandProperty samaccountname
    }
    return $foundUser
}

# Install necessary modules
Install-Module importexcel -scope CurrentUser

# Load the correct sheet from the file
$user = Import-Excel -Path $file -WorkSheetname DATA 

# Make an object for the user to copy from 
$usernameForTheCopiedUser = getUsername $user.COPYUSER
$properties = @{
    username = $usernameForTheCopiedUser
    groups =  Get-ADPrincipalGroupMembership $usernameForTheCopiedUser | Select-Object -ExpandProperty name
}
$copyUser = New-Object -TypeName psobject -Property $properties

# Add the username property to the new user
# Get the first 2 characters of the first name
$firstNameAbbreviation = ($user.NAME).Substring(0,2)
# Get the last name by splitting it at the space, then skipping the first line
$lastName = ($user.NAME).Split(" ") | Select-Object -Skip 1 
$user | Add-Member -MemberType NoteProperty -Name username -Value ($lastName + $firstNameAbbreviation)

# Create the new user
New-ADUser \
    -Name $user.NAME \
    -SamAccountName $user.username \
    -AccountPassword $password \
    -ChangePasswordAtLogon $true \
    -Description $user.TITLE \
    -Office $user.Office \
    -EmailAddress $user.username + "@" + $domain \
    -City "Indianapolis" \
    -State "IN" \
    -Title $user.TITLE \
    -Department $user.depaname \ 
    -Company $user.COMPANY \ 
    -Manager getUsername($user.MANAGER) \ 
    -Division $user.division \ 


# Give new user same groups as copied user
# Get the groups of the copied user, expand the name, and add each to the new user.
Get-ADPrincipalGroupMembership $copyUser.username | Select-Object -ExpandProperty name | ForEach-Object {
    Add-ADGroupMember -Identity $user.username -Members $_}

# Set proxy addresses, department number, and employee number
Set-ADUser -Identity $user.username -Add @{proxyAddresses="SMTP:" + $user.username + "@" + $domain}
Set-ADUser -Identity $user.username -Add @{'departmentNumber' = "$user.depnum"}
Set-ADUser -Identity $user.username -Add @{'employeeNumber' = "$user.empnum"}