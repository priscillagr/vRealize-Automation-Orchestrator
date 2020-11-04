/*JS script to read vRA payload. Must have inputProperties as a Propertie on the workload Input. 
inputPropeties = Workflow Input (Properties)
ipaddress = Workflow Output (string)
hostname = Workflow Output (string)
*/

//Get Ip Address from VM

var ip;
ip = inputProperties.get("addresses");
ipaddress = ip[0][0];

//Get customProperties

var hostname;
var customProperties = new Properties();
customProperties = inputProperties.get("customProperties");
hostname = customProperties.get("vm_name");

//Logs
System.log("IP Variable Type: " +typeof ip);
System.log("Hostname Variable Type: " +typeof hostname);
System.log("Get Payload - Hostname:" + hostname);
System.log("Get Payload - IPAddress:" + ipaddress);
