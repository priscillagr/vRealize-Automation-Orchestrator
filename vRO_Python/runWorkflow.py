# Update for your environment here. Use single quotes around each defined value.
usr = 'administrator@vsphere.local'
pwd = 'VMware1!'
wfid = '01f73c13-38ea-43fc-91a1-2e4ba3b41693'
#NOTE: use double \\ or single / when specifying file path
jsonFile = '/home/vro-python-vra/body.json'
vroServer = 'vro.nuvem.local:443'

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
url = 'https://' + vroServer + '/vco/api/workflows/' + wfid + '/executions'
data = open(jsonFile).read()
# NOTE: verify=False tells Python to ignore SSL Cert issues
# Execute a workflow using a json file for the body:
r = requests.post(url, data=data, verify=False, auth=vroAuth, headers=headers)