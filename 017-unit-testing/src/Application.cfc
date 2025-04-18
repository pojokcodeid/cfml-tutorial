component {
  this.name = "MyApplication"; // Nama aplikasi
  this.applicationTimeout = createTimeSpan(0, 2, 0, 0); // Waktu kedaluwarsa aplikasi

  function onApplicationStart() {
      return true;
  }

  function onRequestStart(string targetPage) {
  }
}
