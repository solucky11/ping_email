

#Pings servers in text file
#If server goes down, emails me and removes server from the list

$filepath = ".\pc.txt"
$servers = Get-Content $filepath 

$servers | %{
   if (test-Connection -ComputerName $_ -Count 2 -quiet)  {
         Write-Host "$_ is online"
     } else { 

write-host "$_ is not online!"

$From = "A@yahoo.com.hk"
$To = "B@yahoo.com.hk" 

$Subject = "Location Floor $_ is not online!"
$Body = "$_ went down at " + $Time 
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"



$cred = New-Object Management.Automation.PSCredential ¡§sender@gmail.com¡¨, (¡§PW¡¨ | ConvertTo-SecureString -AsPlainText -Force)



Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $Cred 

 } }

#Removes server from list if it is offline
#(Get-Content $filepath) | where { $_ -notmatch $offlineservers } | Out-File -FilePath $filepath 