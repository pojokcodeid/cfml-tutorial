component {

  // Public property
  this.name = "UserManager";

  // Private property (tidak bisa diakses dari luar)
  variables.secretKey = "abc123";

  // Public method
  public string function getAppName() {
    return this.name;
  }

  // Private method
  private string function getSecret() {
    return variables.secretKey;
  }

  // Public method that uses private method
  public string function revealSecret() {
    return getSecret(); // Memanggil private method
  }

}
