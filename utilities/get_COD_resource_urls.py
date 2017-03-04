#Fetch list of data resources from City of Denton
#and save the resource name and URL to a file for
#later consumption.
#by Garret Rumohr

import json
import requests
import ipdb

COD_DATA_URL = 'http://data.cityofdenton.com/api/3/action/package_list'
COD_DATA_FETCH_BASE = 'http://data.cityofdenton.com/api/3/action/package_show'
#?id=adur_'

URL_LOG_FILE = 'output.txt'
log_file = open(URL_LOG_FILE, "w")

#counters and result list
total_counter = 0
has_csvjson_counter = 0
total_results = []

# Get resources
cod_data_json = requests.get(COD_DATA_URL)
cod_data = json.loads(cod_data_json.content)

cod_data_list = cod_data['result']


#iterate over resources and look for formats we can ingest

for dataset in cod_data_list:
    
    dataobject_json = requests.get(COD_DATA_FETCH_BASE, params={'id': dataset})
    print(total_counter)
    total_counter += 1
    dataobject_request = json.loads(dataobject_json.content)
    dataobject = dataobject_request['result']
    
    if dataobject['resources']:
        for resource in dataobject['resources']:
            result_pair = {}
            if resource['format'] in ('CSV', 'JSON'):
                result_pair[dataobject['name']] = resource['url']
                total_results.append(result_pair)
                has_csvjson_counter += 1
                print(resource['url'])

print('Has CSV/JSON URL: ' + str(has_csvjson_counter))
print('Total Resources: ' + str(total_counter))

log_file.write(json.dumps(total_results))
log_file.close()            