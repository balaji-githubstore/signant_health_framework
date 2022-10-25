from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from webdriver_manager.firefox import GeckoDriverManager

def get_driver_path(browser_name):
    if browser_name.lower() == 'firefox':
        path=GeckoDriverManager().install()
    elif browser_name.lower() == 'edge':
        path=EdgeChromiumDriverManager().install()
    else:
        path=ChromeDriverManager().install()
    return path
    
    


