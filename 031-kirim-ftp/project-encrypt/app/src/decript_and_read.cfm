<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <cfoutput>
    <cfset ftpServer = "ftp">
    <cfset ftpUsername = "user">
    <cfset ftpPassword = "password">
    <cfset passphrase = "123456">
    <cfset remoteDir = "/">
    <cfset ftpPort = 21>
    <cfset localDir = expandPath("/temp/read/copy/")>
    <cfset localDirOut = expandPath("/temp/read/decripted/")>

    <!--- Login ke FTP --->
    <cfftp 
        action="open" 
        connection="ftpConn" 
        server="#ftpServer#" 
        port="#ftpPort#" 
        username="#ftpUsername#" 
        password="#ftpPassword#" 
        passive="true" 
        stopOnError="true"
    />

    <!--- List file di remote FTP --->
    <cfftp 
        action="listdir" 
        connection="ftpConn" 
        directory="#remoteDir#" 
        name="ftpFiles"
    />

    <!--- Pastikan folder lokal ada --->
    <cfif NOT directoryExists(localDir)>
        <cfdirectory action="create" directory="#localDir#">
    </cfif>
    <cfif NOT directoryExists(localDirOut)>
        <cfdirectory action="create" directory="#localDirOut#">
    </cfif>

    <!--- Download file dari FTP ke lokal --->
    <cfloop query="ftpFiles">
        <cfif ftpFiles.type EQ "file">
            <cfset remoteFile = remoteDir & ftpFiles.name>
            <cfset localFile = localDir & "/" & ftpFiles.name>
            <cfset localFileOut = localDirOut & "/" & ftpFiles.name>

            <cfftp 
                action="getfile" 
                connection="ftpConn" 
                remotefile="#remoteFile#" 
                localfile="#localFile#" 
                failIfExists="false"
            >

            <!--- Dekripsi file --->
            <!--- remove .gpg dari localFile --->
            <cfset outDescript = reReplace(localFileOut, "\.gpg$", "")>
            <cfexecute name="gpg"
                arguments='--batch --yes --passphrase "#passphrase#" --output "#outDescript#" --decrypt "#localFile#"'
                timeout="30"
                variable="result" />
        </cfif>
    </cfloop>

    <!--- Tutup koneksi --->
    <cfftp action="close" connection="ftpConn">
    </cfoutput>
    <cfoutput>Proses selesai.</cfoutput>
    <a href="/">Home</a>
</body>
</html>