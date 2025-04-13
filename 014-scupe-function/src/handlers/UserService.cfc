component displayname="UserService" extends="BaseService" {

  public string function showAccess() {
    var result = "";

    // Akses public method dari parent
    result &= publicHello() & "<br>";

    // Akses package method dari parent (bisa jika dalam folder yang sama)
    result &= packageMessage() & "<br>";

    // Akses private method dari parent (TIDAK BISA - ini akan error kalau dicoba)
    // result &= privateSecret(); // ❌ Akan error jika tidak dikomen

    return result;
  }

  // overtide function suerclass
  public string function getUserRole(numeric userId) {
    var user = super.getUserRole(userId);
    return "Overide "&user;
  }

}
