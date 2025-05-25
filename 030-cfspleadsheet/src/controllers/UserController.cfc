component {
    
    function init(){
        return this;
    }

    private function upload(path, file){
        uploadDir = path;
        
        // Buat folder jika belum ada
        if (!directoryExists(uploadDir)) {
            directoryCreate(uploadDir);
        }
        
        // Upload dan rename
        uploadedFile = fileUpload(
            destination = uploadDir, 
            fileField = file, 
            mode = "makeunique"
        );
        // Ambil ekstensi file original
        fileExt = listLast(uploadedFile.serverFile, ".");
        
        // Generate nama UUID
        uuidName = createUUID() & "." & fileExt;
        
        // Rename file ke UUID
        fileMove(
            source = uploadedFile.serverDirectory & "/" & uploadedFile.serverFile,
            destination = uploadDir & uuidName
        );

        return uuidName;
    }

    public void function downloadExcel(){
        var userModel= new models.UserModel();
        var users = userModel.getAllUsers();
        var spreadsheet = New spreadsheetCFML.Spreadsheet();
        var headers = ["NIK", "Name", "Email", "Age", "DOB", "Jam"];
        var rows = [];
        // Isi data ke array baris
        for (user in users) {
            arrayAppend(rows, [user.nik, user.name, user.email, user.age, user.dob, user.jam ]);
        }

        // Buat workbook dan tambahkan header + rows
        var workbook = spreadsheet.newXlsx("User Report");

        // === 1. Tambahkan judul di baris 1 ===
        var title = "Laporan Data Pengguna";
        spreadsheet.addRow(workbook, [""]); // baris 1
        spreadsheet.setCellValue(workbook, title, 1, 1); // baris 1 kolom A
        spreadsheet.mergeCells(workbook, 1, 1, 1, arrayLen(headers)); // merge A1:C1
        spreadsheet.formatRow(workbook, {
            bold=true, fontSize=16, alignment="center", fontColor="000080"
        }, 1);

        // === 2. Header di baris 2 ===
        spreadsheet.addRow(workbook, headers);
        spreadsheet.formatRow(workbook, {
        bold=true, backgroundColor="C0C0C0", alignment="center"
        }, 2);

        // ====== 3. Tambahkan Data ======
        var datatypes = { 
            string: [1], 
            string: [2], 
            string: [3], 
            numeric: [4], 
            date: [5], 
            time: [6]
        };
        spreadsheet.addRows( workbook=workbook,  data=rows, datatypes=datatypes);

        // === 4. Atur lebar kolom ===
        spreadsheet.setColumnWidth(workbook, 1, 15); // Kolom A: NIK
        spreadsheet.setColumnWidth(workbook, 2, 30); // Kolom B: Name
        spreadsheet.setColumnWidth(workbook, 3, 20); // Kolom C: Email
        spreadsheet.setColumnWidth(workbook, 4, 10); // Kolom D: Age
        spreadsheet.setColumnWidth(workbook, 5, 20); // Kolom E: DOB
        spreadsheet.setColumnWidth(workbook, 6, 10); // Kolom F: Jam

        if (fileExists(expandPath("/temp/spreadsheet.xlsx"))) {
            fileDelete(expandPath("/temp/spreadsheet.xlsx"));
        }
        spreadsheet.write(workbook, expandPath("/temp/spreadsheet.xlsx"));
        cfheader(name="Content-Disposition", value="attachment;filename=spreadsheet.xlsx");
        cfcontent(type="application/vnd.ms-excel", file=expandPath("/temp/spreadsheet.xlsx"), reset=true);
    }

    public any function uploadExcel(){
        spreadsheet = new spreadsheetCFML.Spreadsheet();

        if (!structKeyExists(form, "excelFile")) {
            writeOutput("Tidak ada file yang diupload.");
            abort;
        }
       
        try {
            fileInfo = upload(expandPath("/temp/upload/"), "excelFile");
            filepath = expandPath("/temp/upload/") & fileInfo;

            result = spreadsheet.read( src=filepath, format="arrayOfStructs", headerRow=1 );
            model=new models.UserModel();
            model.insert(data=result);
            // delete file
            fileDelete(filepath);
            writeOutput("Data berhasil disimpan.");
        } catch (any e) {
            writeDump(var = e, label = "ERROR Upload Excel");
        }
    }
}