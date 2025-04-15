component {

	local.config = deserializeJSON(fileRead(expandPath('/config/jwt.json')));
	this.jwtkey=local.config.jwtkey;
	this.expiedMinute = local.config.expiredMinute;
	this.jwtRefreshKey=local.config.refreshKey;
	this.refreshExpiredMinute=local.config.refreshExpiredMinute;

	function generate(data){
		var expdt = dateAdd("n", this.expiedMinute , now());
		var expdtRefresh = dateAdd("n", this.refreshExpiredMinute , now());
		var utcDate = dateDiff("s", dateConvert("utc2Local", createDateTime(1970, 1, 1, 0, 0, 0)), expdt);
		var utcDateRefresh = dateDiff("s", dateConvert("utc2Local", createDateTime(1970, 1, 1, 0, 0, 0)), expdtRefresh);
		var payload = {ts = now(), data = data, exp = utcDate};
		var jwt = new helpers.jwt(this.jwtkey);
		var jwtRefresh = new helpers.jwt(this.jwtRefreshKey);
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
				var jwt = new helpers.jwt(this.jwtkey);
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
