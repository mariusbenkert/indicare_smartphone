import requests
import json
import time
import random
import sys
import numpy as np


def generate_heartRate():
    return random.randint(70, 120)


def generate_stepCount(previous_stepCount):
    if np.random.choice([True, False], size=1, p=[0.8, 0.2])[0]:
        return previous_stepCount + random.randint(0, 10)
    else:
        return previous_stepCount


def generate_activity():
    activites = ['Walking', 'Sitting', 'Fell Down']

    activity = np.random.choice(activites, size=1, p=[0.4, 0.4, 0.2])
    print(activity)

    return activity[0]


def generate_location(previous_lat, previous_long):
    def generate_boolean():
        return random.choice([True, False])

    if generate_boolean():
        new_lat = previous_lat + 0.1
    else:
        new_lat = previous_lat - 0.1

    if generate_boolean():
        new_long = previous_long + 0.1
    else:
        new_long = previous_long - 0.1

    return new_lat, new_long


user_id = ''

if len(sys.argv) < 2:
    raise Exception("No User specified!")
else:
    user_id = sys.argv[1]

url = 'https://ms-project-88b21-default-rtdb.europe-west1.firebasedatabase.app/patients/' + \
    user_id + '/realtimeValues.json'

lat, long = 49.80097, 9.93523
stepCount = 120

while(True):
    # lat, long = generate_location(lat, long)
    stepCount = generate_stepCount(stepCount)

    payload = {
        'heartRate': generate_heartRate(),
        'stepCount': stepCount,
        'activity': generate_activity(),
        'location': {
            'lat': lat,
            'long': long,
        }
    }

    json_payload = json.dumps(payload)

    print(json_payload)

    r = requests.put(url, json_payload)
    time.sleep(10)
