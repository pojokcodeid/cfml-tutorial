<!--- contoh komponent dengan cftag --->
<cfcomponent>

    <cffunction name="sayHello" access="public" returntype="struct">
        <cfreturn { id = 1, name = "John Doe", email = "john@example.com", age = 20 }>
    </cffunction>

</cfcomponent>
