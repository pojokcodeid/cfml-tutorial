component {

  // this scope
  this.appName = "MyApp"; // Bisa diakses dari luar: obj.appName

  // variables scope (private)
  variables.secretKey = "xyz123"; // Tidak bisa diakses langsung dari luar
  local.contoh="contoh"; // ini tidak bisa diacess kedalam function dand ari luar cfc
  // var contoh3="123"; // ini tidak bisa di declarasikan di luar function

  public string function exampleFunction() {
    // var scope (shorthand untuk local)
    var message = "Using var"; // hanya bisa diacess dari dalam function ini

    // local scope (eksplisit)
    local.note = "Using local"; // hanay dapat diacess dari dalam function ini

    return message & " - " & local.note & " screet key = "&variables.secretKey& " pada "&this.appName;
  }

}