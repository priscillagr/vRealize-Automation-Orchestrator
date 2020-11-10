/*JS script to modify vRA 8.X custom Propertie.
inputPropeties = Workflow Input (Properties)
customProperties = Workflow Output (Properties)
*/

var newValue = "novo_valor";
var customProperties = new Properties();
customProperties.put("vraCustomValue",newValue);