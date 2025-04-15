
component accessors="true" {

    property logger;

    function init(){
        LogBoxConfig = new logbox.system.logging.config.LogBoxConfig( CFCConfigPath="/config/LogBox.cfc" );
        LogBox = new logbox.system.logging.LogBox( LogBoxConfig );
        this.logger = LogBox.getRootLogger();
    }

    public void function info(string text){
        this.logger.info(text);
    }
  
    public void function debug(string text){
        this.logger.debug(text);
    }
    
    public void function warn(string text){
        this.logger.warn(text);
    }
    
    public void function error(string text){
        this.logger.error(text);
    }
}
