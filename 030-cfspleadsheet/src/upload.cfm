<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Upload Data Excel</h2>
    <form action="process_upload.cfm" method="post" enctype="multipart/form-data">
        <input type="file" name="excelFile" accept=".xlsx" required>
        <button type="submit">Upload & Simpan ke DB</button>
    </form>
</body>
</html>