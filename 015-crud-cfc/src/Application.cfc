component {
  this.name = "MyApplication";
  this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
  this.sessionManagement = true;

  this.mappings["/cfc"] = expandPath("../../models/em");
  datasourcePath = expandPath("../../config/datasource.json");
  if (fileExists(datasourcePath)) {
    datasourceConfig = deserializeJSON(fileRead(datasourcePath));
    this.datasource = structKeyArray(datasourceConfig)[1];
    this.datasources = datasourceConfig;
  } else {
    writeDump("Datasource config file not found: #datasourcePath#");
    abort;
  }

  function onApplicationStart() {
      return true;
  }

  function onRequestStart(string targetPage) {
  }
}
