<html>
  <head>
    <title>Kalkulator CFML Sederhana</title>
  </head>
  <body>
    <h2>Kalkulator Sederhana</h2>
    <cfparam name="form.operator" default="+">
    <!--- Form input --->
    <form method="post">
      Angka 1: <input type="number" name="angka1" value="#form.angka1#" required><br><br>
      Operator: 
      <select name="operator">
        <option value="+" <cfif form.operator EQ "+">selected</cfif>>+</option>
        <option value="-" <cfif form.operator EQ "-">selected</cfif>>-</option>
        <option value="*" <cfif form.operator EQ "*">selected</cfif>>*</option>
        <option value="/" <cfif form.operator EQ "/">selected</cfif>>/</option>
      </select><br><br>
      Angka 2: <input type="number" name="angka2" value="#form.angka2#" required><br><br>

      <input type="submit" value="Hitung">
    </form>

    <!--- Proses perhitungan --->
    <cfif structKeyExists(form, "angka1") AND structKeyExists(form, "angka2")>
      <cfset hasil = 0>
      <cfset a = val(form.angka1)>
      <cfset b = val(form.angka2)>
      <cfset op = form.operator>

      <cfif op EQ "+">
        <cfset hasil = a + b>
      <cfelseif op EQ "-">
        <cfset hasil = a - b>
      <cfelseif op EQ "*">
        <cfset hasil = a * b>
      <cfelseif op EQ "/" AND b NEQ 0>
        <cfset hasil = a / b>
      <cfelse>
        <cfset hasil = "Tidak valid (pembagian dengan 0?)">
      </cfif>
      <cfoutput>
        <h3>Hasil: #hasil#</h3>
      </cfoutput>
    </cfif>
  </body>
</html>
