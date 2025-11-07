// Create a local administrative account on target vm's via Azure Run Command

# Variables — update as needed
$UserName = "CloudHacker"
$Password = "SomeStrongPass2025!" | ConvertTo-SecureString -AsPlainText -Force

# Check if user already exists
if (Get-LocalUser -Name $UserName -ErrorAction SilentlyContinue) {
    Write-Host "User '$UserName' already exists."
} else {
    # Create the local user
    New-LocalUser -Name $UserName -Password $Password -FullName $UserName
    Write-Host "User '$UserName' has been created."
}

# Add user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $UserName
Write-Host "User '$UserName' added to the Administrators group."
