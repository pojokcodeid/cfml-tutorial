component {
  function sayHello() {
    var sys = createObject("java", "java.lang.System");
    var greeting = sys.getProperty("GREETING", "Default Greeting");
    var name = sys.getProperty("NAME", "Default Name");
    return "#greeting#, #name#!";
  }
}
