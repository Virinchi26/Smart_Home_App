import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("C:\\Users\\shah1\\Desktop\\Mini-Project Folders\\Sem IV Mini-Project\\ha_app\\ha_app\\lib\\Raspberry Pi\\serviceAccountKey.json")
firebase_admin.initialize_app(cred)
database = firestore.client()
collection = database.collection("devices")

while True:
    fans = collection.document('fans').get().to_dict()
    lights = collection.document('lights').get().to_dict()
    print(fans)
    print(lights)