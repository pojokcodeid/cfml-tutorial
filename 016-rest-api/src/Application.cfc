component {
  this.name = "MyApplication";
  this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
  this.sessionManagement = true;

  this.mappings["/"] = expandPath("/helpers");
  datasourcePath = expandPath("/config/datasource.json");
  if (fileExists(datasourcePath)) {
    datasourceConfig = deserializeJSON(fileRead(datasourcePath));
    this.datasource = structKeyArray(datasourceConfig)[1];
    this.datasources = datasourceConfig;
  } else {
    writeDump("Datasource config file not found: #datasourcePath#");
    abort;
  }	

  function onApplicationStart() {
      application.jwtkey = "$3cR3!k@GH34";
		  // Base path dari aplikasi
      basePath = getDirectoryFromPath(getCurrentTemplatePath()) & "models/";

      // Inisialisasi folder "em"
      restInitApplication(
        dirPath = basePath & "em",
        serviceMapping = "em",
        password = "P@ssw0rd"
      );

      // Inisialisasi folder "py"
      restInitApplication(
        dirPath = basePath & "py",
        serviceMapping = "py",
        password = "P@ssw0rd"
      );
      return true;
  }

  function onRequestStart(string targetPage) {
    onApplicationStart();
  }
}
