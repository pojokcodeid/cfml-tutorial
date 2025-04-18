<h1>Welcome to Lucee Rest API</h1>
<cfscript>
    expdt = dateAdd("n", 30, now());
    utcDate = dateDiff("s", dateConvert("utc2Local", createDateTime(1970, 1, 1, 0, 0, 0)), expdt);
    jwt = new jwt(application.jwtkey);
    payload = {ts = now(), userid = "pojokcode", exp = utcDate};
    token = jwt.encode(payload);
    writeOutput("token : " & token & "<br>");
</cfscript>
  
