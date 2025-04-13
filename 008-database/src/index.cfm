<cfoutput>
  <!--- jika ingin mengaksess default datasource --->
  <cfquery name="qUser">
    select * from user
  </cfquery>
  <!--- validari  --->
  <cfif qUser.recordCount>
    <table border="1" cellpadding="3" cellspacing="0">
      <tr>
        <td>No</td>
        <td>Name</td>
        <td>Username</td>
        <td>Password</td>
      </tr>
      <cfloop query="qUser">
        <tr>
          <td>#qUser.currentRow#</td>
          <td>#qUser.name#</td>
          <td>#qUser.username#</td>
          <td>#qUser.password#</td>
        </tr>
      </cfloop>
    </table>
  <cfelse>
    Data user not found
  </cfif>
  <!--- jika ingin menggunkan sfesifik datasource name  --->
  <cfquery name="qUser2" datasource="mydsn">
    select * from user
  </cfquery>
   <cfdump var="#qUser2#">
</cfoutput>