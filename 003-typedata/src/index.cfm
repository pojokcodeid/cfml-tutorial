<cfoutput>
  <cfset message="Hello World">
  <cfparam name ="contoh_param" default="Nilai Default">
  <h1>#message#</h1>
  <p>#contoh_param#</p>

  <cfset nama = "Dian"> <!--- String --->
  <cfset umur = 30> <!--- Number --->
  <cfset aktif = true> <!--- Boolean --->
  <cfset buah = ["apel", "jeruk", "mangga"]> <!--- Array --->
  <cfset user = {
    nama = "Dian",
    umur = 30
  }> <!--- Struct --->

  Nama: #user.nama#<br>
  Umur: #user.umur#<br>
  Buah favorit: #buah[1]#<br> <!--- Index dimulai dari 1 --->

  <!--- scope variable --->
  <!--- Variabel lokal --->
  <!--- Default untuk variabel lokal dalam file --->
  <cfset variables.nama = "Rani">

  <!--- Sesi pengguna --->
  <!--- Berlaku sepanjang sesi browser pengguna --->
  <cfset session.login = true>

  <!--- Variabel aplikasi --->
  <!--- Berlaku sepanjang hidup aplikasi --->
  <cfset application.siteName = "My Website">

  <!--- Data dari URL (misal ?id=123) --->
  <cfoutput>
    variables.nama=#variables.nama#<br>
    session.login=#session.login#<br>
    application.siteName=#application.siteName#<br>
    <!--- Data dari URL query string --->
    ID dari URL: #url.id#
  </cfoutput>
</cfoutput>