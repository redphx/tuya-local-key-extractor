# Tuya Local Key Extractor - With Auto Config 
### Current as of 10/1/25
Get Tuya device's local key easily using [Official Tuya IoT Python SDK](https://github.com/tuya/tuya-iot-python-sdk).

This is a fork of [redphx/tuya-local-key-extractor](https://github.com/redphx/tuya-local-key-extractor) with an automated setup wizard for easier configuration.

## Quick Start (Start here if you already have your Tuya Access ID and Access Secret. If you still need those, follow step 3 in "Manual Installation" section of the guide

1. **Run the setup wizard:**
   - Double-click `setup_wizard.bat`
   - Follow the on-screen prompts
   - The wizard will automatically create your `config.py` file, and prompts you to extract the keys

2. **That's it!** The wizard can run the extraction automatically, or you can run `python extract.py` anytime.

## Manual Installation

1. Install `tuya-iot-python-sdk`:
   ```bash
   pip install tuya-iot-python-sdk
   ```

2. **Important:** Install compatible MQTT library version:
   ```bash
   pip install paho-mqtt==1.6.1
   ```
   ⚠️ The SDK is not compatible with paho-mqtt 2.x

3. **Create Tuya IoT Project:**
   - Follow [this guide](https://github.com/rospogrigio/localtuya) to create a Tuya IoT project

4. **Subscribe to Tuya Cloud Services:**
   - Go to https://iot.tuya.com
   - Navigate to **Cloud** → **Development** → **Cloud Services**
   - Subscribe to **IoT Core** service (free tier available)
   - Make sure the service status shows "In service" (not "Alerting")

5. **Get your API credentials:**
   - Go to your project in the Tuya IoT Platform
   - Navigate to **[Your Project Name]** → **Authorization** → **Cloud Authorization**
   - Copy your **Access ID/Client ID**
   - Copy your **Access Secret/Client Secret**

6. **Run the Setup Wizard if you're on Windows**
   - This will configure the config.py file, and run extract.py for you, but if you'd rather configure and run them manually, or if youre on linux, they can certainly be configured and run one by one. The batch file is basically for future me who forgets how to do this and needs my hand held lol. To configure manually, follow the steps below

7. **Configure:** Edit `config.py` and fill in your credentials

8. **Run:** `python extract.py`

## Configuration Details

Your `config.py` needs:

- **ENDPOINT**: Your region's API endpoint (e.g., `TuyaCloudOpenAPIEndpoint.AMERICA`)
- **COUNTRY_CODE**: Your country's phone code (e.g., `1` for USA)
- **APP**: `AppType.SMART_LIFE` or `AppType.TUYA_SMART`
- **EMAIL**: Your Tuya/Smart Life account email
- **PASSWORD**: Your Tuya/Smart Life account password  
- **ACCESS_ID**: Your Access ID/Client ID from Tuya IoT Platform
- **ACCESS_KEY**: Your Access Secret/Client Secret from Tuya IoT Platform

## Output

Results are saved to `tuya_devices.json`:

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

## Troubleshooting

### "No permissions. Your subscription to cloud development plan has expired"
- Go to https://iot.tuya.com → Cloud → Development → Cloud Services
- Subscribe to or renew the **IoT Core** service
- Free tier is available for personal/development use

### "Unsupported callback API version" or MQTT errors
- Downgrade paho-mqtt: `pip install paho-mqtt==1.6.1`
- The tuya-iot-python-sdk is not compatible with paho-mqtt 2.x

### No devices found (empty array)
- Verify your IoT Core subscription is active
- Check that devices are added to your Tuya Smart Life app
- Ensure `COUNTRY_CODE` and `APP` settings match your account
- Ensure username and password are correct

## Files Included

- **setup_wizard.bat** - Interactive setup wizard for Windows users
- **extract.py** - Main extraction script
- **Readme** - Readme lol
- **config.py** - Config info needed to extract keys

## Credits

- Original repository: [redphx/tuya-local-key-extractor](https://github.com/redphx/tuya-local-key-extractor)
- Based on: [Tuya IoT Python SDK](https://github.com/tuya/tuya-iot-python-sdk)
- Enhanced with automated setup wizard by this fork

## License

Same as the original repository.
