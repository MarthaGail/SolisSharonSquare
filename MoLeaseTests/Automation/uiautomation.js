DEMO_DELAY=2;

target = UIATarget.localTarget();
app = target.frontMostApp();

function navigateToUrl(url) {
    UIALogger.logStart("Test web browser");
    UIALogger.logMessage("Doing stuff");
    // app.toolBar.buttons()["Refresh"].tap();
    UIALogger.logPass("Success");
}

navigateToUrl("http://www.digg.com");

