$PDC=(Get-ADDomain).PDCEmulator

$events=Get-WinEvent -ComputerName $PDC -FilterHashTable @{
    LogName = 'Security'
    ID = 4740

}
$eventexports=@()
foreach( $event in $events )
{
   $eventexports+= [pscustomobject]@{
        Name=$event.Properties[0].Value
        Computer=$event.Properties[1].Value
        Timestamp=$event.TimeCreated
    }


}

$eventexports
$eventexports | Export-Excel C:\AD_Scripts\AccountLockoutHistory.xlsx -Title "List Account Lockout Events in AD"