# tuya-local-key-extractor
Get Tuya device's local key easily using [Official Tuya IoT Python SDK](https://github.com/tuya/tuya-iot-python-sdk).

## Installation
1. Install `tuya/tuya-iot-python-sdk`:
  ```
  pip3 install tuya-iot-py-sdk
  ```

2. Follow [this guide](https://www.home-assistant.io/integrations/tuya/) to create a Tuya IoT project. You'll find `ACCESS_ID` and `ACCESS_KEY` after creating it.

3. Open `config.py` in text editor and fill in info.

4. Run `python3 extract.py` to get local keys.

Sample output:
```json
[
  {
    "device_id": "ce058fxe********",
    "device_name": "Fingerbot Plus",
    "product_id": "blliqpsj",
    "product_name": "Fingerbot Plus",
    "category": "szjqr",
    "uuid": "tuyaea0e********",
    "local_key": "24e3735b********",
    "mac_address": "DC:12:23:**:**:**"
  }
]
```
