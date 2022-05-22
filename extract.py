import json
import logging
import os

from enum import Enum
from tuya_iot import (
    TuyaOpenAPI,
    AuthType,
    TuyaOpenMQ,
    TuyaDeviceManager,
    TuyaCloudOpenAPIEndpoint,
    TUYA_LOGGER,
)


class AppType(Enum):
    TUYA_SMART = 'tuyaSmart'
    SMART_LIFE = 'smartlife'

# Select server. More info: https://github.com/tuya/tuya-iot-python-sdk/blob/main/tuya_iot/tuya_enums.py
ENDPOINT = TuyaCloudOpenAPIEndpoint.AMERICA

# Change to AppType.SMART_LIFE for Smart Life app
APP = AppType.TUYA_SMART
# Your Tuya Smart/Smart Life account
EMAIL = ''
PASSWORD = ''

# Get these info on https://iot.tuya.com
ACCESS_ID = ''
ACCESS_KEY = ''

# TUYA_LOGGER.setLevel(logging.DEBUG)

openapi = TuyaOpenAPI(ENDPOINT, ACCESS_ID, ACCESS_KEY, AuthType.SMART_HOME)
openapi.connect(EMAIL, PASSWORD, country_code=84, schema=APP.value)

openmq = TuyaOpenMQ(openapi)
openmq.start()

device_manager = TuyaDeviceManager(openapi, openmq)
device_manager.update_device_list_in_smart_home()

devices = []
for tuya_device in device_manager.device_map.values():
    device = {
        'name': tuya_device.name,
        'product_name': tuya_device.product_name,
        'uuid': tuya_device.uuid,
        'local_key': tuya_device.local_key,
    }

    devices.append(device)

print(json.dumps(devices, indent=2))
os._exit(0)