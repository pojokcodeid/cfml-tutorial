component {
  
    variables.jarPaths = [
        expandPath("./lib/password4j-1.5.3.jar"),
        expandPath("./lib/commons-lang3-3.12.0.jar"),
        expandPath("./lib/slf4j-api-1.7.30.jar"),
        expandPath("./lib/slf4j-nop-1.7.30.jar")
    ];
  
    function init() {
        return this;
    }

    function bcryptHashGet(required string input) {
        var Password = createObject("java", "com.password4j.Password", variables.jarPaths);
        var hash = Password.hash(input).withBcrypt().getResult();
        return hash;
    }

    function bcryptHashVerify(required string input, required string hashedInput) {
        var Password = createObject("java", "com.password4j.Password", variables.jarPaths);
        var result = Password.check(input, hashedInput).withBcrypt();
        return result;
    }
  
}

  