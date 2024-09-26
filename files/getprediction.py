import requests
import json
import sys


def get_prediction(url,kmh,temp):
    headers = {"content-type": "application/json"}
    r = requests.get(url, headers=headers)
    if (r.ok):
        print(json.dumps(r.json()))
    else:
        print("API call predictions: " + str(r.status_code))
        return (False)
    return(r.json()['result'])

def main(argv):
    kmh=argv[1]
    temp=argv[2]
    api_url='<my url>'    # example https://hirokixxx.atp.eu-frankfurt-1.oraclecloudapps.com/
    api_user='<my user>'
    url=f'{api_url}ords/{api_user}/wsapi/predict?kmh='+str(kmh)+'&temp='+str(temp)
    prediction=get_prediction(url,kmh,temp)
    if prediction == False:
        print('Prediction REST API failed: '+url)
    else:
        print("Estimated range: "+prediction)

if __name__ == "__main__":
    main(sys.argv)
