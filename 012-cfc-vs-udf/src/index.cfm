<!--- UDF (User-Defined Function) --->
<cffunction name="multiply" access="public" returnType="numeric">
  <cfargument name="a" type="numeric">
  <cfargument name="b" type="numeric">
  <cfreturn arguments.a * arguments.b>
</cffunction>

<cfset math = new cfc.MyMath()>
<cfoutput>penjumlahan 5 dan 3 = #math.add(5, 3)#</cfoutput><br> <!-- Output: 8 -->
<cfoutput>perkalian 4 dan 2 = #multiply(4, 2)#</cfoutput> <!-- Output: 8 -->