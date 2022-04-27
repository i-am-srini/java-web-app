from os import environ
import requests
import datetime
import time
import json
import boto3
url = 'http://3.86.190.118:8001/api/ec2_image_report/'
text_file = open("ARN.txt", "r")
temparn = text_file.read()
text_file.close()
client = boto3.client('inspector', region_name='us-west-2')
assessment = client.start_assessment_run(
assessmentTemplateArn = (temparn),
assessmentRunName = datetime.datetime.now().isoformat()
)
class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
      if isinstance(obj, (datetime.date, datetime.datetime)):
        return obj.isoformat()
findings = client.list_findings(
    assessmentRunArns=[
        assessment['assessmentRunArn']
    ],
    filter={
        'severities': [
            'High', 'Medium',
        ],
    },
    maxResults=100
)
time.sleep(1800)
final_data =[]
for z in (findings['findingArns']):
    response = client.describe_findings(findingArns=[z])
    responses = json.dumps(response, cls=DateTimeEncoder)
    a = json.loads(responses)
    final_data.append(a)
print(final_data)
head = {'content-type': 'application/json', 'Authorization': 'eyJhdXRoIjogIlRoZV9wb3N0X3Z1bG5lcmFiaWxpdHlfZGF0YSJ9'}
x = requests.post(url, data=json.dumps({"imageData":final_data}), headers = head)
print(x)