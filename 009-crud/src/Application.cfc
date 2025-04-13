component {
  this.name = "MyApplication"; // Nama aplikasi
  this.applicationTimeout = createTimeSpan(0, 2, 0, 0); // Waktu kedaluwarsa aplikasi
  // Path relatif ke folder /config dari dalam folder /src
  datasourcePath = expandPath("../config/datasource.json");

  // Baca JSON dan simpan ke this.datasources
  if (fileExists(datasourcePath)) {
    datasourceConfig = deserializeJSON(fileRead(datasourcePath));

    // Ambil nama datasource pertama sebagai default
    this.datasource = structKeyArray(datasourceConfig)[1];
    this.datasources = datasourceConfig;
  } else {
    // Handle jika file tidak ditemukan
    writeDump("Datasource config file not found: #datasourcePath#");
    abort;
  }

  function onApplicationStart() {
      return true;
  }

  function onRequestStart(string targetPage) {
  }
}
