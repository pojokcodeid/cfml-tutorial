<cfquery name="qDelete">
  delete from personal where id= <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation url="index.cfm" addtoken="false">