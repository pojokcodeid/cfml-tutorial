<cfset excelFile = expandPath("/temp/spreadsheet.xlsx")>
<cfset encryptedFile = expandPath("/temp/encripted/data.xlsx.gpg")>
<cfset lastFile = listLast(encryptedFile, "/")>
<cfset myEnv = createObject("core.helpers.EnvLoader")>
<cfset ftpServer = myEnv.getEnv("FTP_SERVER") />
<cfset ftpUser = myEnv.getEnv("FTP_USER") />
<cfset ftpPass = myEnv.getEnv("FTP_PASS") />
<cfset FTPPort = myEnv.getEnv("FTP_PORT") />
<cfset passphrase = myEnv.getEnv("FTP_PASSPHARSE")>

<!--- Enkripsi file Excel --->
<cfexecute name="gpg"
    arguments='--batch --yes --passphrase "#passphrase#" --symmetric --cipher-algo AES256 --output "#encryptedFile#" "#excelFile#"'
    timeout="30"
    variable="result" />

<cfif fileExists(encryptedFile)>
    <cfoutput>
        File terenkripsi: #encryptedFile#<br>
        Mengirim ke FTP...
    </cfoutput>

    <!--- Kirim file ke FTP menggunakan lftp --->
    <cfftp action="open" 
        connection="myConn" 
        username="#ftpUser#" 
        password="#ftpPass#" 
        server="#ftpServer#" 
        port="#FTPPort#"
        stopOnError="true"/>

    <cfftp 
        action="putFile"
        connection="myConn"
        localFile="#encryptedFile#"
        remoteFile="/#lastFile#"
        failIfExists="false"
    />
    <cfoutput>File terkirim ke FTP.</cfoutput>
    <!--- baca file di server dengan cfftp --->
    <cfftp action="listdir" connection="myConn" 
    name="filesList" directory="/" 
    stopOnError="true">
    <cfoutput>Daftar file di FTP:</cfoutput>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Tipe</th>
            <th>Nama</th>
            <th>Length</th>
        </tr>
        <cfloop query="filesList">
            <tr>
                <td><cfoutput>#filesList.type#</cfoutput></td>
                <td><cfoutput>#filesList.name#</cfoutput></td>
                <td><cfoutput>#filesList.LENGTH#</cfoutput></td>
            </tr>
        </cfloop>
    </table>
    <cfftp action="close" connection="myConn" />
    <a href="/">Home</a>
<cfelse>
    <cfoutput>Gagal mengenkripsi file.</cfoutput>
</cfif>