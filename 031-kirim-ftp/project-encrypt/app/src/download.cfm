<cfparam name="type" default="excel" >
<cfset users = createObject("controllers.UserController") />
<cfif type eq "excel">
    <cfset users.downloadExcel() />
<cfelse>
    <cfset users.downloadPdf() />
</cfif>