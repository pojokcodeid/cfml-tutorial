
component extends="core.BaseController" {
    variables.emp = model("em.EmployeeModel");
    variables.rules = {
        name  : "required|min:3|max:20",
        email : "required|is_email|max:50",
        age: "required|is_numeric"
    }

    public function init() {
        return this;
    }

    public struct function sayHay(id){
        return emp.sayHay(id);
    }

    public struct function getAll(){
        try{
            return { 
                code: 200,
                success=true,
                message="Get All Data Success", 
                data = emp.getAllData()
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: []
            };
        }
    }

    public struct function getById(id){
        try{
            return { 
                code: 200,
                success=true,
                message="Get Data Success", 
                data = emp.getById(id)
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: {}
            };
        }
    }

    private void function uploadAttach(content={}){
        if (structKeyExists(content, "lampiran")) { 
            // Ambil informasi file upload
            fileField = "lampiran";
            uploadDir = expandPath("/public/uploads/");
          
            // Buat folder jika belum ada
            if (!directoryExists(uploadDir)) {
              directoryCreate(uploadDir);
            }
          
            // Upload dan rename
            uploadedFile = fileUpload(
                destination = uploadDir, 
                fileField = fileField, 
                mode = "makeunique"
            );
            // Ambil ekstensi file original
            fileExt = listLast(uploadedFile.serverFile, ".");
          
            // Generate nama UUID
            uuidName = createUUID() & "." & fileExt;
            content.lampiran = uuidName;
            
            // Rename file ke UUID
            fileMove(
              source = uploadedFile.serverDirectory & "/" & uploadedFile.serverFile,
              destination = uploadDir & uuidName
            );

        }
    }

    public any function createData(content={}){
        var result = validate(content, rules);
        var retdata = {
            name: content.name,
            email: content.email,
            age: content.age
        }
        if(result.success){
            try{
                if(structKeyExists(content, "lampiran")){
                    content.lampiran = upload(expandPath("/public/uploads/"), content.lampiran);
                }
                return { 
                    code: 200,
                    success=true,
                    message="Create Data Success", 
                    data = emp.createData(content)
                };
            }catch (any e) {
                return {
                    success = false,
                    code = 500,
                    message = e.message,
                    data = retdata
                }
            }
        }else{
           return {
                success = false,
                code = 400,
                message = result.errors[1],
                data = retdata
           }
        }
    }

    public any function updateData(id, content={}){
        var result = validate(content, rules);
        var retData = {
            id: id,
            name: content.name,
            email: content.email,
            age: content.age,
            attachment: content.lampiran
        }
        if(result.success){
            try{
                content.id= id;
                // check data exists 
                var data = emp.getById(id);
                if(not structKeyExists(data, "id")){
                    flash("danger", "Data not found");
                    redirect("/employee");
                }
                // cek apakah lampiran ada isinya 
                if(structKeyExists(content, "lampiran") && len(trim(content.lampiran)) > 0){
                    // hapus file lama 
                    if( structKeyExists(data, "attachment") && len(trim(data.attachment)) > 0){
                         var fileToDelete = expandPath("/public/uploads/") & data.attachment;
                         if(fileExists(fileToDelete)){
                            fileDelete(fileToDelete);
                         }
                    }
                    // upload file baru
                    if (structKeyExists(content, "lampiran")) {
                        content.lampiran = upload(expandPath("/public/uploads/"), content.lampiran);
                    }
                }
                return {
                    success: true,
                    code: 200,
                    message: "Update employee success",
                    data: emp.updateData(content)
                }
            }catch (any ex) {
                return {
                    success: false,
                    code: 500,
                    message: ex.message,
                    data: retData
                }
            }
        }else{
            return {
                success: false,
                code: 400,
                message:  result.errors[1],
                data: retData
            };
        }
    }

    public any function deleteData(id){
        try{
            // check data exists 
            var data = emp.getById(id);
            if(not structKeyExists(data, "id")){
                return {
                    code: 404,
                    success: false,
                    message: "Not Found",
                    data: {}
                };
            }
            if(emp.deleteData(id).id != id){
                data = {}
            }else{
                // hapus file lama 
                if( structKeyExists(data, "attachment") && len(trim(data.attachment)) > 0){
                    var fileToDelete = expandPath("/public/uploads/") & data.attachment;
                    if(fileExists(fileToDelete)){
                        fileDelete(fileToDelete);
                    }
                }
                return { 
                    code: 200,
                    success=true,
                    message="Delete Data Success", 
                    data = data
                };
            }
        }catch (any e) {
            return {
                success = false,
                code = 500,
                message = e.message,
                data = {}
            }
        }
    }
    
}