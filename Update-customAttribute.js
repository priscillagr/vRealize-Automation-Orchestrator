/*
Script em JS para fazer update de customAttribute e adiconar novas propriedades.

Reference: https://www.vmwarebits.com/content/updating-custom-properties-vrealize-automation-8-deployment-vrealize-orchestrator-workflow
Validaded Versions: vRA 8.1
*/


//Variables
var customAtt;
var resourceNames;
var vmName;
var customProperties = mew Properties();


//Get existing customProperties and change it

customProperties = inputProperties.get("custom");
customAtt = "customAttributeModified";

//Modify custom Propertie and create a new one

customProperties.put("custom",customAtt);
customProperties.put("newcustom", customAtt);

//Get createdBlueprint customProperties

userInput = customProperties.get("customAttribute");

//DEBUG
System.log("Get Payload - VM Name:" + vmName);
System.log("Get Payload - Custom:" + customAtt);
