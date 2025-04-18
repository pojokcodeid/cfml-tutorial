<cfoutput>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Report - #errorID#</title>
    <style>
        body { font-family: Arial, sans-serif; background: ##f9f9f9; padding: 2em; }
        h1 { color: ##c0392b; }
        .error-box { background: ##fff; padding: 1.5em; border: 1px solid ##ddd; border-radius: 8px; }
        .section { margin-bottom: 1.5em; }
        code, pre { background: ##f4f4f4; padding: 0.5em; display: block; overflow-x: auto; }
    </style>
</head>
<body>
    <div class='error-box'>
        <h1>⚠️ Application Error</h1>
        <div class='section'><b>Error ID:</b> #errorID#</div>
        <div class='section'><b>Timestamp:</b> #now()#</div>

        <div class='section'><b>Cookie:</b><cfdump var="#cookie#" label="Cookie"></div>
        <div class='section'><b>Form:</b><cfdump var="#form#" label="Form"></div>
        <div class='section'><b>URL:</b><cfdump var="#url#" label="URL"></div>
        <div class='section'><b>CGI:</b><cfdump var="#cgi#" label="CGI"></div>
        <div class='section'><b>Server:</b><cfdump var="#server#" label="Server"></div>

        <div class='section'><b>Exception Message:</b><cfdump var="#exception.message#" label="Exception"></div>
        <div class='section'><b>Exception Detail:</b><cfdump var="#exception.detail#" label="Exception"></div>
        <div class='section'><b>Exception Struct:</b><cfdump var="#exception#" label="Exception"></div>
        <div class='section'><b>Stack Trace:</b><cfdump var="#exception.tagContext#" label="Exception"></div>
        
        <cfif structKeyExists(exception, "detail") && findNoCase("Transaction (Process ID", exception.detail)>
            <div class='section'><b>SQL Buffer (Deadlock):</b>
                <cftry>
                    <cfset strDiag = exception.detail>
                    <cfset intStart = findNoCase("Transaction (Process ID", strDiag)>
                    <cfset intEnd = findNoCase(")", strDiag, intStart)>
                    <cfset strSub = mid(strDiag, intStart, intEnd - intStart)>
                    <cfset strSub = trim(replaceList(strSub, "Transaction (Process ID,),", ""))>
                <cfcatch>
                    Cannot display SQL log.
                </cfcatch>
                </cftry>
            </div>
        </cfif>
    </div>
</body>
</html>
</cfoutput>
