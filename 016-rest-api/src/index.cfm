<h1>Welcome to Lucee Rest API</h1>
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
  
