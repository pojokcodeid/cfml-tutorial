component displayname="BaseService" {

  // PUBLIC method - dapat diwarisi dan diakses
  public string function publicHello() {
    return "Hello from BaseService (public)";
  }

  // PRIVATE method - hanya bisa diakses dalam class ini saja
  private string function privateSecret() {
    return "This is private secret from BaseService";
  }

  // PACKAGE method - bisa diakses dari subclass jika berada dalam package yang sama
  package string function packageMessage() {
    return "Package-level message from BaseService";
  }

  //DEFAULT (tanpa `access` keyword, dianggap PUBLIC di CFML)
  string function getUserRole(numeric userId) {
    return "Standard User";
  }

  // Method untuk memanggil semua internal method
  public string function testBaseAccess() {
    return publicHello() & " | " & privateSecret() & " | " & packageMessage();
  }

}
