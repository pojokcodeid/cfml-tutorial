<html>
  <head><title>Formulir Pendaftaran</title></head>
  <body>
    <h2>Formulir Pendaftaran</h2>

    <form method="post">
      Nama: <input type="text" name="nama"><br><br>
      Umur: <input type="number" name="umur"><br><br>
      <input type="submit" value="Kirim">
    </form>

    <cfif structKeyExists(form, "nama")>
      <cfif trim(form.nama) EQ "" OR NOT isNumeric(form.umur)>
        <cfoutput><strong>Mohon isi data dengan benar.</strong></cfoutput>
      <cfelse>
        <cfoutput>
          <hr>
          <strong>Data Terkirim!</strong><br>
          Nama: #form.nama#<br>
          Umur: #form.umur# tahun
        </cfoutput>
      </cfif>
    </cfif>
  </body>
</html>
