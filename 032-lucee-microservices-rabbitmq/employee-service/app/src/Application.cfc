component {

    this.name = 'MyApplication'; // Nama aplikasi
    this.applicationTimeout = createTimespan(0, 2, 0, 0); // Waktu kedaluwarsa aplikasi
    this.javaSettings = {loadPaths: [
        'lib/mariadb', 
        'lib/rabbitmq',
        'lib/password4j'
        ], reloadOnChange: true};

    globalConfig = expandPath('/configs/global.json');
    config = deserializeJSON(fileRead(globalConfig));
    
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

    function onApplicationStart() {
        application.baseURL = myEnv.getEnv("BASE_URL");
        application.emailFrom = myEnv.getEnv("EMAIL_FROM");
        return true;
    }

    function onRequestStart(string targetPage) {
        header name="Access-Control-Allow-Origin" value="#myEnv.getEnv("FE_URL")#";
        header name="Access-Control-Allow-Credentials" value="true";
        header name="Access-Control-Allow-Methods" value="GET, POST, PUT, DELETE, OPTIONS";
        header name="Access-Control-Allow-Headers" value="Content-Type, Authorization";

        if (cgi.request_method == 'OPTIONS') {
            cfheader(statuscode = "204", statustext = "No Content");
            abort;
        }

        return true;
    }

    /*
	this.onError = function(exception, eventname){
        var uuid = createUUID();
		var strSpt = "/";
		if (findNoCase("Windows", server.OS.Name)) strSpt = "\";
        var targetPath = getDirectoryFromPath(getCurrentTemplatePath()) & "/logs";
        if (not directoryExists(targetPath)) {
            directoryCreate(targetPath);
        }
		targetPath = targetPath & strSpt & uuid & ".html";
        savecontent variable="strDump" {
            writeDump(var=exception, label="Exception", format="html");
        }
		try {
			fileWrite(targetPath, strDump);
		} catch (any writeErr) {
			if (isDefined("strDump")) {
				log text="Error while writing error file: #writeErr.message# - Dump: #strDump#" file="SFErrorHandler";
			}
		}
        cfheader(statuscode="500", statustext="Error Internal Server");
        cfheader(name="Content-Type", value="application/json");
        writeOutput(serializeJSON({
            success=false,
            code=500,
            message="Something went wrong",
            data={},
            errorcode=uuid
        },true));
        return false;
    }
    */
    // gunakan ini untuk config mail server
    // https://myaccount.google.com/apppasswords
    this.mail = {
        server: myEnv.getEnv("GMAIL_HOST"),
        username:  myEnv.getEnv("GMAIL_USERNAME"), // ganti dengan email kamu
        password: myEnv.getEnv("GMAIL_PASSWORD"), // ganti dengan App Password (bukan password biasa)
        port: myEnv.getEnv("GMAIL_PORT"),
        useSSL: myEnv.getEnv("GMAIL_USESSL"),
        useTLS: myEnv.getEnv("GMAIL_USETLS") // Gmail SSL pakai port 465
    };

}
