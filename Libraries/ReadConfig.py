"""
Python Function to read variables from properties file
"""
import os
import configparser


def read_config(cfg_file):
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    cfg_path = os.path.join(BASE_DIR, cfg_file)
    if cfg_path is not None:
        config1 = configparser.RawConfigParser()
        if os.path.exists(cfg_path):
            config1.read(cfg_path)
        return config1


config = read_config('resources.properties')

port_address = config.get("DEVICE_DETAILS", "PORT_ADDRESS")
port_address = config.get("DEVICE_DETAILS", "PORT_ADDRESS")
device_name = config.get("DEVICE_DETAILS", "DEVICE_NAME")
platform_name = config.get("DEVICE_DETAILS", "PLATFORM_NAME")

app_name = config.get("APP_DETAILS", "APP_NAME")
package_name = config.get("APP_DETAILS", "PACKAGE_NAME")
activity_name = config.get("APP_DETAILS", "ACTIVITY_NAME")

user_email = config.get("USER_DETAILS", "EMAIL_ID")
user_password = config.get("USER_DETAILS", "PASSWORD")

# Links
login_url = config.get("API_Links", "Login_URL")
Status_url = config.get("API_Links", "Status_URL")
create_channel_url = config.get("API_Links", "Create_Channel_URL")
delete_channel_url = config.get("API_Links", "Delete_Channel_URL")
update_username_url = config.get("API_Links", "Update_UserName_URL")
verify_channel_url = config.get("API_Links", "Verify_Channel_URL")
call_directChat_url = config.get("API_Links", "Call_directChat_URL")
chat_postInChannel_url = config.get("API_Links", "Chat_postInChannel_URL")
update_chatInChannel_url = config.get("API_Links", "Update_chatInChannel_URL")
chat_react_url = config.get("API_Links", "Chat_react_URL")


# Cloud
access_key = config.get("Browser_Stack","ACCESSKEY")
username_cloud = config.get("Browser_Stack","USERNAME_CLOUD")
device_name_Cloud = config.get("Browser_Stack","DEVICE_NAME_CLOUD")
app_id_cloud = config.get("Browser_Stack","APP_ID")