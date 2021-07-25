#Pings servers in text file
#If server goes down, emails me and removes server from the list

$filepath = ".\pc.txt"
$servers = Get-Content $filepath 

$servers | %{
   if (test-Connection -ComputerName $_ -Count 2 -quiet)  {
         Write-Host "$_ is online"
     } else { 

write-host "$_ is not online!"

#Email settings
$ToAddress = "A@yahoo.com.hk"
$FromAddress = "B@yahoo.com.hk"
$secpasswd = ConvertTo-SecureString ¡§Password¡¨ -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($ToAddress, $secpasswd)
$Time = (Get-Date) 
$Subject = "$_ is not online!" 
$Body = "$_ went down at " + $Time 
$SMTP =  "smtp.mail.com"
$Port = "25"

#Email using office 365 
#Send-MailMessage -To $ToAddress -SmtpServer $SMTP -Credential $mycreds -UseSsl $Subject -Port $Port -Body $Body -From $FromAddress -BodyAsHtml
Send-MailMessage -To $ToAddress -SmtpServer $SMTP  -Subject $Subject  -Body $Body -From $FromAddress -BodyAsHtml

$Offlineservers = $_

 } }

#Removes server from list if it is offline
#(Get-Content $filepath) | where { $_ -notmatch $offlineservers } | Out-File -FilePath $filepath 