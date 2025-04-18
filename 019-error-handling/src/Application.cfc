component output="false" {
	this.name = "MyApplication"; // Nama aplikasi
	this.applicationTimeout = createTimeSpan(0, 2, 0, 0); // Waktu kedaluwarsa aplikasi
	this.sessionManagement = true;
	this.logDir = expandPath("/logs");
	
	function onApplicationStart() {
		return true;
	}

	function onRequestStart(string targetPage) {
		return true;
	}

	function onError(exception, eventName) {
		var timestamp = dateFormat(now(), "yyyymmdd") & "T" & timeFormat(now(), "HHmmss");
		var uuid = createUUID();
		var errorID = "error-" & timestamp & "-" & uuid;
	
		// Path separator
		var strSpt = "/";
		if (findNoCase("Windows", server.OS.Name)) strSpt = "\";
	
		var targetPath = getDirectoryFromPath(getCurrentTemplatePath()) & "logs" & strSpt & errorID & ".html";
	
		// Render file HTML dari template
		savecontent variable="strDump" {
			include "/configs/ErrorTemplate.cfm";
		}
	
		// Simpan file log
		try {
			fileWrite(targetPath, strDump);
		} catch (any writeErr) {
			if (isDefined("strDump")) {
				log text="Error while writing error file: #writeErr.message# - Dump: #strDump#" file="SFErrorHandler";
			}
		}
	
		// Output to user
		writeOutput("
			<h2>Oops! Something went wrong.</h2>
			<p>Please contact support with this reference ID:</p>
			<code>#errorID#</code>
		");
	
		return false;
	}			
	
}
