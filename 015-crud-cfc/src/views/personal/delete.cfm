<cfset personal = new cfc.Personal()>
<cfset delete = personal.deletePersonal(url.id)>
<cfif delete>
  <cflocation url="index.cfm" addtoken="false">
<cfelse>
  <p>Error : Delete Field ...</p>
</cfif>