
<cfset scupe =new cfc.Scupe()>
<cfoutput>
#scupe.exampleFunction()#
</cfoutput>

<!--- contoh enkasulasi --->
<br>
<cfset userMgr = new cfc.UserManager()>

<cfoutput>
  #userMgr.getAppName()# <!-- Output: UserManager -->
  #userMgr.revealSecret()# <!-- Output: abc123 -->
</cfoutput>

<!-- Tidak bisa akses ini -->
<!-- #userMgr.secretKey# => ERROR -->
<!-- #userMgr.getSecret()# => ERROR -->
