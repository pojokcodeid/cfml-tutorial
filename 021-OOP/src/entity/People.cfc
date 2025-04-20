
component {
    property name="nama";
    property name="tlp";

    public void function setNama(nama){
        variables.nama=nama;
    }

    public string function getNama(){
        return variables.nama;
    }

    public void function setTlp(tlp){
        variables.tlp=tlp;
    }

    public string function getTlp(){
        return variables.tlp;
    }
}