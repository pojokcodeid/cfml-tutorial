<cfset nilai = 82>

<cfif nilai GTE 90>
  <cfoutput>Nilai huruf: A</cfoutput>
<cfelseif nilai GTE 80>
  <cfoutput>Nilai huruf: B</cfoutput>
<cfelseif nilai GTE 70>
  <cfoutput>Nilai huruf: C</cfoutput>
<cfelse>
  <cfoutput>Nilai huruf: D atau E</cfoutput>
</cfif>

<br>
<cfset username = "admin">
<cfset password = "1234">

<cfif username EQ "admin" AND password EQ "1234">
  <cfoutput>Login berhasil!</cfoutput>
<cfelseif username EQ "admin">
  <cfoutput>Password salah!</cfoutput>
<cfelse>
  <cfoutput>Username tidak ditemukan!</cfoutput>
</cfif>

<br>
<cfset hari = "Senin">

<cfswitch expression="#hari#">
  <cfcase value="Senin">
    <cfoutput>Awal minggu, semangat kerja!</cfoutput>
  </cfcase>
  
  <cfcase value="Sabtu, Minggu">
    <cfoutput>Selamat akhir pekan!</cfoutput>
  </cfcase>
  
  <cfdefaultcase>
    <cfoutput>Hari biasa.</cfoutput>
  </cfdefaultcase>
</cfswitch>
