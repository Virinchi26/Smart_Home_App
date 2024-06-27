import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, timedelta

# Use a service account
cred = credentials.Certificate('C:\\Users\\shah1\\Desktop\\Mini-Project Folders\\Sem IV Mini-Project\\ha_app\\lib\\Raspberry Pi\\serviceAccountKey.json')
firebase_admin.initialize_app(cred)

# Get a Firestore client
db = firestore.client()

# Define the appliances and their paths
appliances = [ 
    {
        'name': 'light1',
        'path': 'devices/lights',
        'device_ids': ['1'],
        'timer': None
    },
    {
        'name': 'light2',
        'path': 'devices/lights',
        'device_ids': ['2'],
        'timer': None
    },
    {
        'name': 'fan1',
        'path': 'devices/fans',
        'device_ids': ['1'],
        'timer': None
    },
    {
        'name': 'fan2',
        'path': 'devices/fans',
        'device_ids': ['2'],
        'timer': None
    },
]

# Update the appliances
for appliance in appliances:
    path = appliance['path']
    doc_ref = db.document(path)
    for device_id in appliance['device_ids']:
        doc_ref.update({
            device_id: False
        })

# Start the timer loop
while True:
    # Check each appliance and update the Firestore document if necessary
    for appliance in appliances:
        path = appliance['path']
        doc_ref = db.document(path)
        status_dict = doc_ref.get().to_dict()

        # If any device is turned on and there is no timer for this appliance, start a new timer
        if any(status_dict[device_id] for device_id in appliance['device_ids']) and appliance['timer'] is None:
            duration = timedelta(seconds=10)
            end_time = datetime.now() + duration

            # Create a new timer for this appliance
            appliance['timer'] = {'end_time': end_time}

            # Start the timer for the appliance
            appliance_name = appliance['name']
            timer_secs = duration.total_seconds()
            timer_doc_ref = db.collection('appliance_timer').document(appliance_name)
            timer_doc_ref.set({
                'timeout': False,
                'completed': False,
                'start_time': firestore.SERVER_TIMESTAMP,
                'timer_secs': timer_secs
            })

        # If there is a timer for this appliance, check if it has expired
        elif appliance['timer'] is not None:
            end_time = appliance['timer']['end_time']
            if datetime.now() >= end_time:
                # Update the Firestore document to turn off all devices of the appliance
                for device_id in appliance['device_ids']:
                    doc_ref.update({
                        device_id: False
                    })

                # Check if the user has responded to the notification
                timer_doc_ref = db.collection('appliance_timer').document(appliance['name'])
                timer_doc = timer_doc_ref.get()
                if timer_doc.exists:
                    data = timer_doc.to_dict()
                    if data['timeout'] == True:
                        # User has not responded, switch off the appliance
                        print(f"Appliance {appliance['name']} not completed. Switching off...")
                    elif data['completed'] == True:
                        # User has completed the task, keep the appliance on
                        print(f"Appliance {appliance['name']} completed. Keeping on...")
                    else:
                        # User has not completed the task, switch off the appliance
                        print(f"Appliance {appliance['name']} not completed. Switching off...")
                        # Remove the timer for this appliance
                        appliance['timer'] = None
                        timer_doc_ref.delete()

                # Wait for 1 second before checking again
                time.sleep(1)

