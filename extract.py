import json
import logging
import os
import re

from config import (
    ENDPOINT,
    COUNTRY_CODE,
    APP,
    EMAIL,
    PASSWORD,
    ACCESS_ID,
    ACCESS_KEY,
)

from tuya_iot import (
    TuyaOpenAPI,
    AuthType,
    TuyaOpenMQ,
    TuyaDeviceManager,
)

mac_format = re.compile(r"(?:[0-9A-Fa-f]{2}\:){5}(?:[0-9A-Fa-f]{2})")

openapi = TuyaOpenAPI(ENDPOINT, ACCESS_ID, ACCESS_KEY, AuthType.SMART_HOME)
openapi.connect(EMAIL, PASSWORD, country_code=COUNTRY_CODE, schema=APP.value)

openmq = TuyaOpenMQ(openapi)
openmq.start()

device_manager = TuyaDeviceManager(openapi, openmq)
device_manager.update_device_list_in_smart_home()

devices = []
for tuya_device in device_manager.device_map.values():
    device = {
        'device_id': tuya_device.id,
        'device_name': tuya_device.name,
        'product_id': tuya_device.product_id,
        'product_name': tuya_device.product_name,
        'category': tuya_device.category,
        'uuid': tuya_device.uuid,
        'local_key': tuya_device.local_key,
    }

    try:
        resp = openapi.get('/v1.0/devices/factory-infos?device_ids={}'.format(tuya_device.id))
        factory_info = resp['result'][0]
        if 'mac' in factory_info:
            mac = factory_info['mac'].upper()
            if not mac_format.match(mac):
                mac = ':'.join(factory_info['mac'][i:i + 2] for i in range(0, 12, 2))
            device['mac_address'] = mac
    except Exception as e:
        print(e)

    devices.append(device)

print(json.dumps(devices, indent=2))
os._exit(0)
