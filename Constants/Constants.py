from keyring.testing.util import random_string

URL = "https://open.rocket.chat/"
NEW_NAME = "CustomUsername1234689"
STATUS = "Online"
NEW_CHANNEL_NAME = random_string(10)
CUSTOM_STATUS_TEXT = "NHK NHK"
POST_CHAT_IN_CHANNEL = "Successfully posted chat in channel"
UPDATE_CHAT_IN_CHANNEL = "Successfully updated chat in channel"
DIRECT_MESSAGE_NAME = "Mobile"
EMOJI_NAME = "headdesk"
TEXT_TO_SPEAK = "welcome to text to speech trial in this world"
AUDIO_FILE_NAME = random_string(10) + ".mp3"

login_payload = {
    "message": "{\"msg\":\"method\",\"id\":\"76\",\"method\":\"login\",\"params\":[{\"user\":{\"email\":\"appiumtesting7@gmail.com\"},\"password\":{\"digest\":\"358d2397c763c180ae8d8eaa4197d813dce124b04fdad86630b396e11fbfaf0f\",\"algorithm\":\"sha-256\"}}]}"}

login_username_payload = {
    "message": "{\"msg\":\"method\",\"id\":\"18\",\"method\":\"login\",\"params\":[{\"user\":{\"username\":\"CustomUsername1234689\"},\"password\":{\"digest\":\"358d2397c763c180ae8d8eaa4197d813dce124b04fdad86630b396e11fbfaf0f\",\"algorithm\":\"sha-256\"}}]}"}

login_payload2 = {
    "message": "{\"msg\":\"method\",\"id\":\"76\",\"method\":\"login\",\"params\":[{\"user\":{\"email\":\"nalotib946@esmoud.com\"},\"password\":{\"digest\":\"1c170d32dc2192deb080bc143fa617a52ba58fce8250daae040774b04bd5138c\",\"algorithm\":\"sha-256\"}}]}"}
