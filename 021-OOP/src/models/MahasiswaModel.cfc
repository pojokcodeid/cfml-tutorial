component implements="interface.IMahasiswaModel"{
    
    property name="datasource";

    function init(){
        var dsn = new helpers.GlobalConfig();
        variables.datasource = dsn.datasource; 
    }

    public string function getDatasource(){
        return variables.datasource;
    }

    public array function getAllMahasiswa(){
        var mahasiswas = [];
        arrayAppend(mahasiswas,new entity.Mahasiswa("00001","Pojok Code","1234567"));
        arrayAppend(mahasiswas,new entity.Mahasiswa("00002","John","876543"));
        return mahasiswas;
    }
}