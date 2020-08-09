Get-Module ActiveDirectory
Get-Module ExportExcel

#Get all Enabled User in AD with Membership Property
$user_list=Get-ADUser -Filter {Enabled -eq $true} -Properties MemberOf

#Format to object list for easily export report
$UserAndGroups=@()
foreach ($user in $user_list)
{
   $UserAndGroups+=[pscustomobject]@{
        Name = $user.Name
        User = $user.SamAccountName
        Membership = ($user.MemberOf | ForEach-Object {Get-ADGroup $_}).Name -Join ","
        LogonName=$user.UserPrincipalName    

    } 

} 
$UserAndGroups | Export-Excel C:\AD_Scripts\UsersGroupsList.xlsx -Title "Enabled Users vmt.local"