/*JS script to read vRA 8.X payload. Must have inputProperties as a Propertie on the workload Input. 
inputPropeties = Workflow Input (Properties)
ipaddress = Workflow Output (string)
hostname = Workflow Output (string)
*/

//Variables
var ip;
var userInput;
var ipaddress;
var resourceNames;
var vmName;
var osType;
var customProperties = mew Properties();

//Get IpAddress and ResourceName from vRA

ip = inputProperties.get("addresses");
ipaddress = ip[0][0];
resourceNames = inputProperties.get("resourceNames");
vmName = resourceNames[0];

//Get existing customProperties

customProperties = inputProperties.get("customProperties");
osType = customProperties.get("osType");

//Get createdBlueprint customProperties

userInput = customProperties.get("input_hostname");

//Logs
System.log("IP Variable Type: " +typeof ip);
System.log("Hostname Variable Type: " +typeof hostname);
System.log("Get Payload - Hostname:" + hostname);
System.log("Get Payload - IPAddress:" + ipaddress);
System.log("Get Payload - OS:" + osType);
System.log("Get Payload - VM Name:" + vmName);

