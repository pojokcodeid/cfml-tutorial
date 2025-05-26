
component {

    function init(){}
    
    public any function getEnv(key=""){
        var sys = createObject("java", "java.lang.System");
        if(key == "") return sys.getenv();
        return sys.getenv()[key];
    }
}