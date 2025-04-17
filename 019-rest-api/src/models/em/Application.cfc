component {
    this.name = "MyApplication";
    this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
    this.sessionManagement = true;
    this.onError = function(exception, eventname){
        var uuid = createUUID();
		var strSpt = "/";
		if (findNoCase("Windows", server.OS.Name)) strSpt = "\";
		var targetPath = getDirectoryFromPath(getCurrentTemplatePath()) & "../../logs" & strSpt & uuid & ".html";
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
            message="Something went wrong",
            data={},
            errorcode=uuid
        },true));
        return false;
    }
}