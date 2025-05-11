component {

    function begin() {
        app = new core.App();
        app.setDefaultController("Default");
        app.setDefaultControllerMethod("index");
        app.get("/employee/say-hay", { controller: "em.EmployeeController", method: "sayHay"});
        app.get("/employee", { controller: "em.EmployeeController", method: "getAll"});
        app.get("/employee/add", { controller: "em.EmployeeController", method: "addNew"});
        app.get("/employee/edit/:id", { controller: "em.EmployeeController", method: "getById"});
        app.post("/employee/edit/:id", { controller: "em.EmployeeController", method: "updateData"});
        app.post("/employee", { controller: "em.EmployeeController", method: "createData"});
        app.get("/employee/delete/:id", { controller: "em.EmployeeController", method: "deleteData"});
        app.run();
    }
}
