component {
    this.name = "cfspleadsheet example";
    this.sessionManagement = false;
    this.javaSettings = {
        loadPaths = ["libs/mariadb"],
        reloadOnChange = true
    };
    variables.myEnv= createObject("core.helpers.EnvLoader");
    variables.connDSN = myEnv.getEnv("CONN_DSN");
    variables.connClass = myEnv.getEnv("CONN_CLASS");
    variables.connString = myEnv.getEnv("CONN_STRING");
    variables.connUsername = myEnv.getEnv("CONN_USER");
    variables.connPassword = myEnv.getEnv("CONN_PASS");
    this.datasource = connDSN;
    this.datasources = {
        "#connDSN#" : {
            class: connClass,
            connectionString: connString,
            username: connUsername,
            password: connPassword
        }
    }
}