component {

    public string function default() {
        return "Selamat datang di API CFML Lucee";
    }

    public string function tambah() {
        param name="url.a" default=0;
        param name="url.b" default=0;

        return "Hasil: " & application.mathService.tambah(url.a, url.b);
    }

    public string function halo() {
        param name="url.nama" default="Dunia";

        return application.mathService.sayHello(url.nama);
    }

    public string function besar() {
        param name="url.text" default="halo";

        return application.mathService.getUpperCase(url.text);
    }

}
