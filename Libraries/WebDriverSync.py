"""
This File manages the webdriver
"""
from webdriver_manager.chrome import ChromeDriverManager


def get_driver_path():
    # Returns the driver path via Chrome Driver Manager
    driver_path = ChromeDriverManager().install()
    return driver_path
