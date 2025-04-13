<!--- array --->
<cfset myArray = arrayNew(1)> <!--- Array satu dimensi --->
<cfset arrayAppend(myArray, "Apel")>
<cfset arrayAppend(myArray, "Pisang")>
<cfset arrayAppend(myArray, "Jeruk")>

<cfoutput>
    Jumlah item: #arrayLen(myArray)#<br>
    Item pertama: #myArray[1]#
</cfoutput>

<!--- struct --->
<cfset user = structNew()>
<cfset structInsert(user, "name", "John Doe")>
<cfset structInsert(user, "email", "john@example.com")>
<cfset user.age = 30> <!--- Cara alternatif --->
    
<cfoutput>
    Nama: #user.name#<br>
    Email: #user.email#<br>
    Umur: #user["age"]#<br>
    Jumlah Properti: #structCount(user)#
</cfoutput>

<!--- looping array --->
<cfset fruits = ["Apel", "Pisang", "Jeruk"]>

<cfoutput>
    <ul>
    <cfloop from="1" to="#arrayLen(fruits)#" index="i">
        <li>#fruits[i]#</li>
    </cfloop>
    </ul>
</cfoutput>

<!--- looping struct --->
<cfset user = {name="Jane", email="jane@example.com", age=25}>

<cfoutput>
    <ul>
    <cfloop collection="#user#" item="key">
        <li>#key#: #user[key]#</li>
    </cfloop>
    </ul>
</cfoutput>

<!--- contoh lainnya --->
<cfset users = [
    {name="Alice", email="alice@example.com"},
    {name="Bob", email="bob@example.com"},
    {name="Charlie", email="charlie@example.com"}
]>

<cfoutput>
    <table border="1">
        <tr>
            <th>Nama</th>
            <th>Email</th>
        </tr>
        <cfloop array="#users#" index="user">
            <tr>
                <td>#user.name#</td>
                <td>#user.email#</td>
            </tr>
        </cfloop>
    </table>
</cfoutput>
