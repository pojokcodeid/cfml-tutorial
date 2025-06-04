component {

    function init(){
        return this;
    }
    
    public any function getEnv(key=""){
        var sys = createObject("java", "java.lang.System");
        if(key == "") return sys.getenv();
        return sys.getenv()[key];
    }
}