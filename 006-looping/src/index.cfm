<!--- loop dengan index --->
<cfloop index="i" from="1" to="5">
  <cfoutput>Perulangan ke-#i#<br></cfoutput>
</cfloop>

<!--- loop dengan array --->
<cfset buah = ["apel", "jeruk", "pisang"]>

<cfloop array="#buah#" index="item">
  <cfoutput>Buah: #item#<br></cfoutput>
</cfloop>

<!--- Loop Melalui Struct --->
<cfset user = {nama="Budi", umur=25, kota="Bandung"}>

<cfloop collection="#user#" item="key">
  <cfoutput>#key#: #user[key]#<br></cfoutput>
</cfloop>

<!--- Loop Bersyarat --->
<cfset x = 1>

<cfloop condition="x LTE 3">
  <cfoutput>x = #x#<br></cfoutput>
  <cfset x++>
</cfloop>

<!--- cfbreak --->
<cfloop index="i" from="1" to="5">
  <cfif i EQ 3>
    <cfbreak>
  </cfif>
  <cfoutput>i = #i#<br></cfoutput>
</cfloop>
<!-- Output: i = 1, i = 2 (berhenti saat i = 3) -->

<!--- cfcontinue --->
<cfloop index="i" from="1" to="5">
  <cfif i MOD 2 EQ 0>
    <cfcontinue>
  </cfif>
  <cfoutput>Bilangan ganjil: #i#<br></cfoutput>
</cfloop>
