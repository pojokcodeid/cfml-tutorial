<cfoutput>
    <cfif structKeyExists(session, "user")>
      <h2>Welcome, #session.user.name#</h2>
      <img src="#session.user.picture#" width="100">
      <p>Email: #session.user.email#</p>
      <a href="logout.cfm">Logout</a>
    <cfelse>
      <a href="login.cfm">Login with Google</a>
    </cfif>
</cfoutput>
