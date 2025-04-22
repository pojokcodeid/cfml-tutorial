<h1>Welcome to Lucee Rest API</h1>
<cfset jwt = new modules.jwtcfml.models.jwt()>
<cfset payload = {'key': 'value', 'iat': now(), 'exp':now()}>
<cfset secret = 'secret'>
<cfset token = jwt.encode(payload, secret, 'HS256')>
<cftry>
  <cfset decode = jwt.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NDUzMTg4OTQsImV4cCI6MTc0NTMxODg5NCwia2V5IjoidmFsdWUifQ.R9tS_f_32FjouzQW1tXER3Xu4WvUDoKDtZjfJkyqXOY",
   secret, 'HS256')>
   <cfcatch>
    <cfoutput>#cfcatch.Message#<br></cfoutput>
    <!--- <cfoutput>#cfcatch.Detail#<br></cfoutput> --->
  </cfcatch>
</cftry>
<cfoutput>
  #token#<br>
  <!--- #serializeJSON(decode)# --->
</cfoutput>
<!--- <cfscript>
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
  
