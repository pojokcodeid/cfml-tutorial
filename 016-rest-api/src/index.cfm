<!--- <h1>Welcome to Lucee Rest API</h1>
<cfscript>
  passwordUtil = new Password();
  
  // Hash password
  plainPassword = "userPassword123!";
  hashedPassword = passwordUtil.bcryptHashGet(plainPassword);
  writeOutput("Hashed Password: " & hashedPassword &"<br>");
  // Verifikasi password
  isValid = passwordUtil.bcryptHashVerify("userPassword123!", hashedPassword);
  writeOutput("Password valid: " & isValid);
</cfscript>
<br><br> --->
<!--- <cfset expdt =  dateAdd("n",30,now())>
<cfset utcDate = dateDiff('s', dateConvert('utc2Local', createDateTime(1970, 1, 1, 0, 0, 0)), expdt) />
<cfset jwt = createObject("component", "helpers.jwt").init(application.jwtkey)>
<cfset payload = {"ts" = now(), "userid" = "pojokcode", "exp" = utcDate}>
<cfset token = jwt.encode(payload)>
<cfoutput>
  token : #token# <br>
</cfoutput> --->
  
