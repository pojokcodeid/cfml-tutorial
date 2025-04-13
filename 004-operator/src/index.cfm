<!--- operator aritmatika --->
<cfset a = 10>
<cfset b = 3>

<cfoutput>
  Tambah: #a + b#<br>
  Kurang: #a - b#<br>
  Kali: #a * b#<br>
  Bagi: #a / b#<br>
  Sisa Bagi (MOD): #a MOD b#<br>
</cfoutput>
<!--- contoh operator perbandingan --->
<cfset nilai = 80>

<cfif nilai GTE 75>
  <cfoutput>Lulus<br></cfoutput>
<cfelse>
  <cfoutput>Tidak Lulus<br></cfoutput>
</cfif>

<!--- operator logika --->
<cfset umur = 20>
<cfset status = "mahasiswa">

<cfif umur GTE 18 AND status EQ "mahasiswa">
  <cfoutput>Kamu memenuhi syarat.<br></cfoutput>
<cfelse>
  <cfoutput>Tidak memenuhi syarat.<br></cfoutput>
</cfif>

<!--- contoh gabungan --->
<cfset nilai1 = 70>
<cfset nilai2 = 85>
<cfset rataRata = (nilai1 + nilai2) / 2>

<cfif rataRata GTE 75 AND rataRata LTE 100>
  <cfoutput>Lulus dengan nilai rata-rata #rataRata#<br></cfoutput>
<cfelse>
  <cfoutput>Tidak lulus (Rata-rata: #rataRata#)<br></cfoutput>
</cfif>