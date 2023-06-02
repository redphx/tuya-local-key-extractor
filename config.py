from enum import Enum
from tuya_iot import TuyaCloudOpenAPIEndpoint


class AppType(Enum):
    TUYA_SMART = 'tuyaSmart'
    SMART_LIFE = 'smartlife'


# Select server of your Tuya Smart/Smart Life account.
# More info: https://github.com/tuya/tuya-iot-python-sdk/blob/main/tuya_iot/tuya_enums.py
ENDPOINT = TuyaCloudOpenAPIEndpoint.AMERICA

# Calling country code. For example: USA = 1
# Full list: https://en.wikipedia.org/wiki/List_of_country_calling_codes#Alphabetical_order
COUNTRY_CODE = 1

# Change to AppType.SMART_LIFE for Smart Life app
APP = AppType.TUYA_SMART

# Your Tuya Smart/Smart Life app account
EMAIL = ''
PASSWORD = ''

# Get these info on https://iot.tuya.com
ACCESS_ID = ''
ACCESS_KEY = ''
