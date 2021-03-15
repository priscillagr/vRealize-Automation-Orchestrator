# Update for your environment here. Use single quotes around each defined value.
usr = 'admin@local'
pwd = 'VMware1!'
passwdid = '8d962d36-0e6f-4df1-8030-77bcd70b702a'
#NOTE: use double \\ or single / when specifying file path
jsonFile = '/home/vro-python-vra/root.json'
lcmServer = '10.0.0.6'

##Caso não queria usar o arquivo jsonFile, podemos fazer o parse direamente no codigo com
# 
#dataParse = {"rootPassword":"VMware1!"}
#data = json.dumps(dataParse)
#

##### Make no changes below this line ####
# Import the modules to handle HTTP calls and work with json:
#
# requests: http://docs.python-requests.org/en/latest/user/install/
# To install the "requests" module, python -m pip install requests
# json (http://docs.python.org/2/library/json.html)
#
#####
import requests, json
requests.packages.urllib3.disable_warnings()

# Create basic authorization for API
vroAuth = requests.auth.HTTPBasicAuth(usr,pwd)
# Set headers to allow for json format
headers = {'Content-Type':'application/json','Accept':'application/json'}
url = 'https://' + lcmServer + '/lcm/locker/api/passwords/view/' + passwdid
data = open(jsonFile).read()
# NOTE: verify=False tells Python to ignore SSL Cert issues
# Execute a workflow using a json file for the body:
r = requests.post(url, data=data, verify=False, auth=vroAuth, headers=headers)
print(r.content)

#Parse JSON Responde Body
response = json.loads(r.content)
print(response["password"])
