component {
  this.name = "MyApp";
  this.sessionManagement = false;
  this.applicationTimeout = createTimeSpan(1,0,0,0);
  this.mappings["/cfc"] = expandPath("./models");

  function onApplicationStart() {
      application.mathService = new models.MathService();
      return true;
  }
}
