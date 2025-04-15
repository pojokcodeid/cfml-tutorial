component {

  this.name = "lucee-logbox-app";
  this.sessionManagement = false;
  this.applicationTimeout = createTimeSpan(1,0,0,0);

  LogBoxConfig = new logbox.system.logging.config.LogBoxConfig( CFCConfigPath="/config/LogBox.cfc" );
  LogBox = new logbox.system.logging.LogBox( LogBoxConfig );
  logger = LogBox.getRootLogger();

  function onApplicationStart() {
    logger.info( 'Application Initialized.' );
    logger.warn( 'This method is deprecated.' );
    logger.error( 'Error placing order')
    return true;
  }

  function onRequestStart(targetPage) {
    onApplicationStart();
    return true;
  }
}
