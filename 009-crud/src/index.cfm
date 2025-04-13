<cfoutput>
  <!--- jika ingin mengaksess default datasource --->
  <cfquery name="qPersonal">
    select * from personal
  </cfquery>
  <!--- validari  --->
  <p>
    <a href="add.cfm">Add New</a>
  </p>
    <table width="50%" border="1" cellpadding="3" cellspacing="0">
      <tr>
        <td>No</td>
        <td>Name</td>
        <td>Email</td>
        <td>Age</td>
        <td></td>
      </tr>     
      <cfif qPersonal.recordCount>
      <cfloop query="qPersonal">
        <tr>
          <td>#qPersonal.currentRow#</td>
          <td>#qPersonal.name#</td>
          <td>#qPersonal.email#</td>
          <td>#qPersonal.age#</td>
          <td>
            <a href="edit.cfm?id=#qPersonal.id#">Edit</a>&nbsp;
            <a href="delete.cfm?id=#qPersonal.id#">Delete</a>
          </td>
        </tr>
      </cfloop>
    <cfelse>
      <tr>
        <td colspan="5" align="center">-- No Record --</td>
      </tr>
    </cfif>
    </table>
</cfoutput>