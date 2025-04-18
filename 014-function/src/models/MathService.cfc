component {

    public numeric function tambah(numeric a, numeric b) {
        return a + b;
    }

    public numeric function kurang(numeric a, numeric b) {
        return a - b;
    }

    public string function sayHello(string name = "User") {
        return "Hello, " & name;
    }

    public string function getUpperCase(required string inputText) {
        return uCase(inputText);
    }

}
