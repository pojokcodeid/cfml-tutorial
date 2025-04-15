component {   
    function configure() {
        logBox = {
            // Register Appenders
            appenders = {
                // rujukan https://logbox.ortusbooks.com/usage/appender-properties/rollingfileappender
                MyAsyncFile = {
                    class='dependencies.logbox.system.logging.appenders.RollingFileAppender',
                    properties={
                        filePath=expandPath( '../logs' ),
                        filename="MyLog",
                        fileMaxSize=2000  // 2mb
                    }
                },
            },
            // Root Logger. Assign all appenders
            root = { appenders='*' }
        };
    }
}