
component extends="People"{
    
    property name="nim";

    function init(
        nim, nama, tlp
    ){
        variables.nim=nim;
        super.setNama(nama);
        super.setTlp(tlp);
        return this;
    }

    public void function setNim(nim){
        variables.name=nim;
    }

    public string function getNim(){
        return variables.nim;
    }
}