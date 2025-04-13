<cfset personal = new cfc.Personal()>
<cfset qPersonal = personal.listPersonal()>
<cfoutput>
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
        <cfif not isEmpty(qPersonal)>
            <cfset row=0>
            <cfloop array="#qPersonal#" item="personal" >
                <cfset row= row +1 >
                <tr>
                    <td>#row#</td>
                    <td>#personal.name#</td>
                    <td>#personal.email#</td>
                    <td>#personal.age#</td>
                    <td>
                    <a href="edit.cfm?id=#personal.id#">Edit</a>&nbsp;
                    <a href="delete.cfm?id=#personal.id#">Delete</a>
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