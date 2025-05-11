
component extends="core.BaseController" {

    variables.emp = model("em.EmployeeModel");
    variables.rules = {
        // name  : "required|strong_password|min:3|max:20",
        name  : "required|min:3|max:20",
        email : "required|is_email|max:50",
        age: "required|is_numeric"
    }
    
    public function init() {
        return this;
    }


    public any function getAll(){
        var content=[];
        try{
            content = emp.getAllData();
        }catch (any exName) {
            flash("danger", exName.message);
        }
        view("emp.index", {
            data: content
        });
    }

    public any function addNew(){
        view("emp.add");
    }

    public any function getById(id){
        var content={};
        try{
            content= emp.getById(id);
        }catch (any exName) {
            flash("danger", exName.message);
        }
        view("emp.edit", {
            data: content
        });
    }

    public any function createData(content={}){
        var uuidName = "";
        var result = validate(content, rules);
        var retdata = {
            name: content.name,
            email: content.email,
            age: content.age
        };
        if(result.success){
            try{
                if (structKeyExists(content, "lampiran")) {
                    content.lampiran = upload(expandPath("/public/uploads/"), content.lampiran);
                }
                emp.createData(content);
                flash("success", "Create Data Success");
                redirect("/employee");
            }catch (any exName) {
                flash("danger", exName.message, retdata);
                redirect("/employee/add");
            }
        }else{
            flash("danger", result.errors[1], retdata);
            redirect("/employee/add");
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
        };
        if(result.success){
            try{
                content.id = id;
                // check data exists 
                var data = emp.getById(id);
                if (not structKeyExists(data, "id")) { 
                    flash("danger", "Data Not Found");
                    redirect("/employee");
                }
                // cek apakah lampiran ada isinya
                if (structKeyExists(content, "lampiran") && len(trim(content.lampiran)) > 0) {
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
                emp.updateData(content);
                flash("success", "Update Data Success");
                redirect("/employee");
            }catch (any exName) {
                flash("danger", exName.message, retData);
                redirect("/employee/edit/" & id);
            }
        }else{
            flash("danger", result.errors[1], retData);
            redirect("/employee/edit/" & id);
        }
    }
    public struct function deleteData(id){
        try{
            // check data exists 
            var data = emp.getById(id);
            if (not structKeyExists(data, "id")) { 
                flash("danger", "Data Not Found");
                redirect("/employee");
            }
            // hapus file lama 
            if( structKeyExists(data, "attachment") && len(trim(data.attachment)) > 0){
                    var fileToDelete = expandPath("/public/uploads/") & data.attachment;
                    if(fileExists(fileToDelete)){
                        fileDelete(fileToDelete);
                    }
            }
            var result = emp.deleteData(id);
            if(result.id != 0){        
                flash("success", "Delete Data Success");
                redirect("/employee");
            }else{
                flash("danger", "Delete Data Failed");
                redirect("/employee");
            }
        }catch (any exName) {
            flash("danger", exName.message);
            redirect("/employee");
        }
    }
    
}