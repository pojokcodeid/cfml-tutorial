<cfoutput>
<cfset personal = new cfc.Personal()>
<cfset qData = personal.getPersonalById(url.id)>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Personal</title>
</head>
<body>
  <form method="POST" action="">
    <table>
      <tr>
        <td colspan="3">
          <h1>Input Personal Data</h1>
        </td>
      </tr>
      <tr>
        <td>Name</td>
        <td>:</td>
        <td>
          <input type="text" name="name" value="#qData.name#">
        </td>
      </tr>
      <tr>
        <td>Email</td>
        <td>:</td>
        <td>
          <input type="text" name="email" value="#qData.email#">
        </td>
      </tr>
      <tr>
        <td>Age</td>
        <td>:</td>
        <td>
          <input type="text" name="age" value="#qData.age#">
        </td>
      </tr>
      <tr>
        <td>
          <a href="index.cfm">Back</a>
        </td>
        <td></td>
        <td>
          <input type="submit" value="Save">
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
<cfif structKeyExists(form, "name")>
  <cfif trim(form.name) EQ "" OR trim(form.email) EQ "" OR NOT isNumeric(form.age)>
    <cfoutput><strong>Mohon isi data dengan benar.</strong></cfoutput>
  <cfelse>
    <cfset update = personal.updatePersonal({
      id=url.id,
      name=form.name,
      email=form.email,
      age=form.age
    })>
    <cfif update>
      <cflocation url="index.cfm" addtoken="false">
    <cfelse>
      <p>Error : Update field ...</p>
    </cfif>
  </cfif>
</cfif>
</cfoutput>