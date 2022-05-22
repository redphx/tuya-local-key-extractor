import json
import logging
import os

from config import (
    ENDPOINT,
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


openapi = TuyaOpenAPI(ENDPOINT, ACCESS_ID, ACCESS_KEY, AuthType.SMART_HOME)
openapi.connect(EMAIL, PASSWORD, country_code=84, schema=APP.value)

openmq = TuyaOpenMQ(openapi)
openmq.start()

device_manager = TuyaDeviceManager(openapi, openmq)
device_manager.update_device_list_in_smart_home()

devices = []
for tuya_device in device_manager.device_map.values():
    device = {
        'device_id': tuya_device.id,
        'device_name': tuya_device.name,
        'product_name': tuya_device.product_name,
        'uuid': tuya_device.uuid,
        'local_key': tuya_device.local_key,
    }

    try:
        resp = openapi.get('/v1.0/iot-03/devices/factory-infos?device_ids={}'.format(tuya_device.id))
        factory_info = resp['result'][0]
        if 'mac' in factory_info:
            mac = ':'.join(factory_info['mac'][i:i + 2] for i in range(0, 12, 2))
            device['mac_address'] = mac
    except Exception:
        pass

    devices.append(device)

print(json.dumps(devices, indent=2))
os._exit(0)