<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <cfset userModel = createObject("models.UserModel") />
  <cfset users = userModel.getAllUsers() />
  <cfinclude template="/templates/userTemplate.cfm" /><br><br>
  <a href="http://localhost:8888/download.cfm?type=excel">Download Excel</a> &nbsp;
  <a href="http://localhost:8888/download.cfm?type=pdf">Download PDF</a> &nbsp;
  <a href="http://localhost:8888/upload.cfm">Upload</a> &nbsp;
  <a href="http://localhost:8888/template.cfm">Template</a> &nbsp;
  <a href="http://localhost:8888/encrypt_and_send.cfm">Encrypt and Send</a>
</body>
</html>