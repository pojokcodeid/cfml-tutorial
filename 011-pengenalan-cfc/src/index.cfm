<cfset action = url.action ?: "list">
<cfset personalHandler = new cfc.Personal()>
<cfset result = personalHandler.sayHello()>
<cfset personalHandler2 = new cfc.Personal2()>
<cfset result2 = personalHandler2.sayHello()>

<cfoutput>
    <pre>#serializeJSON(result)#</pre>
    <pre>#serializeJSON(result2)#</pre>
</cfoutput>