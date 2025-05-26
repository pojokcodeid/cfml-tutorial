<cfoutput>
    <h1>User Report</h1>
    <table border="1" cellpadding="5" cellspacing="0">
      <tr>
        <th>NIK</th>
        <th>Name</th>
        <th>Email</th>
        <th>Age</th>
        <th>DOB</th>
        <th>Jam</th>
      </tr>
      <cfloop array="#users#" index="user">
        <tr>
          <td>#user.nik#</td>
          <td>#user.name#</td>
          <td>#user.email#</td>
          <td>#user.age#</td>
          <td>#dateFormat(user.dob, "yyyy-mm-dd")#</td>
          <td>#timeFormat(user.jam, "HH:mm")#</td>
        </tr>
      </cfloop>
    </table>
</cfoutput>
