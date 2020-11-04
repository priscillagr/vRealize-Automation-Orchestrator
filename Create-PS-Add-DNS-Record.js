/*JS script to create PowerShell script to run on PowerShell Host.
NoteToRegister = Workflow Variable (string)
IPAddress = Workflow Variable (string)
DNSServer = Workflow Variable (string)
ZoneNae = Workflow Variable (string)
script = Workflow Output (string)
*/


//PowerShell Script
script = 'Add-DnsServerResourceRecordA -Name "'+NodeToRegister+'" '
        +'-ComputerName "'+DNSServer+'" '
        +'-ZoneName "'+ZoneName+'" '
        +'-AllowUpdateAny -IPv4Address "'+IPAddress+'" '
        +'-CreatePTR;';

//Logs
System.log("Hostname: " + NodeToRegister);
System.log("IP Addres: " + IPAddress);
System.log("DNS Zone: " + ZoneName);
System.log("DNS Server: " +DNSServer );
System.log("Script: " +script);