component {
	// Panggil Application.cfc yang berada di root dir
	if (fileExists(expandPath('/config/global.json'))) {
		local.config = deserializeJSON(fileRead(expandPath('/config/global.json')));
	}else{
		local.config = deserializeJSON(fileRead(expandPath('./config/global.json')));
	}
	
	variables.jwtkey=local.config.jwtkey;
	variables.expiedMinute = local.config.expiredMinute;
	variables.jwtRefreshKey=local.config.refreshKey;
	variables.refreshExpiredMinute=local.config.refreshExpiredMinute;
	this.datasource=local.config.datasource;

	function generate(data){
		var expdt = dateAdd("n", variables.expiedMinute , now());
		var expdtRefresh = dateAdd("n", variables.refreshExpiredMinute , now());
		var utcDate = dateDiff("s", dateConvert("utc2Local", createDateTime(1970, 1, 1, 0, 0, 0)), expdt);
		var utcDateRefresh = dateDiff("s", dateConvert("utc2Local", createDateTime(1970, 1, 1, 0, 0, 0)), expdtRefresh);
		var payload = {ts = now(), data = data, exp = utcDate};
		var jwt = new helpers.jwt(variables.jwtkey);
		var jwtRefresh = new helpers.jwt(variables.jwtRefreshKey);
		var token = jwt.encode(payload);
		var tokenRefresh = jwtRefresh.encode(payload);
		return {
			accessToken= token,
			refreshToken=tokenRefresh
		};
	}

	/**
	 * @return any
	 */	
	function authenticate() {
		var response = {};
		var requestData = GetHttpRequestData();
		if (StructKeyExists(requestData.Headers, "authorization")) {
			var token = requestData.Headers.authorization;
			token = replace(token, "Bearer ", "", "all");
			token = replace(token, " ", "", "all");
			try {
				var jwt = new helpers.jwt(variables.jwtkey);
				var result = jwt.decode(token);
				response["payload"] = result;
				response["success"] = true;
				response["message"] = "Authenticate success";
			} catch (any e) {
				response["payload"] = "";
				response["success"] = false;
				response["message"] = e.message;
				return response;
			}
		} else {
			response["payload"] = "";
			response["success"] = false;
			response["message"] = "Authorization token invalid or not present.";
		}
		return response;
  	}

	/**
	 * @return any
	 */	
	function authenticateRefresh() {
		var response = {};
		var requestData = GetHttpRequestData();
		if (StructKeyExists(requestData.Headers, "authorization")) {
			var token = requestData.Headers.authorization;
			token = replace(token, "Bearer ", "", "all");
			token = replace(token, " ", "", "all");
			try {
				var jwt = new helpers.jwt(variables.jwtRefreshKey);
				var result = jwt.decode(token);
				response["payload"] = result;
				response["success"] = true;
				response["message"] = "Authenticate success";
			} catch (any e) {
				response["payload"] = "";
				response["success"] = false;
				response["message"] = e.message;
				return response;
			}
		} else {
			response["payload"] = "";
			response["success"] = false;
			response["message"] = "Authorization token invalid or not present.";
		}
		return response;
  	}

}
