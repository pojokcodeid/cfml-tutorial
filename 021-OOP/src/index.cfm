<cfoutput>
<cfset mhsModel = new models.MahasiswaModel()>
<cfset mhsList = mhsModel.getAllMahasiswa()>
<cfset dsn = mhsModel.getDatasource()>
datasourceny adalah = #dsn#<br>
  <cfloop array="#mhsList#" item="mhs">
      NIM  = #mhs.getNim()#<br>
      Nama = #mhs.getNama()# <br>
      TLP  = #mhs.getTlp()#<br>
      <hr>
  </cfloop>
</cfoutput>
  