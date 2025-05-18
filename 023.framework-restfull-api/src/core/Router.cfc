component {

    function begin() {
        app = new core.App();
        app.setDefaultController("Default");
        app.setDefaultControllerMethod("index");
        app.get("/employee/say-hay", { controller: "em.EmployeeController", method: "sayHay"});
        app.get("/employee", { controller: "em.EmployeeController", method: "getAll"});
        app.get("/employee/:id", { controller: "em.EmployeeController", method: "getById"});
        app.post("/employee", { controller: "em.EmployeeController", method: "createData"});
        app.put("/employee/:id", { controller: "em.EmployeeController", method: "updateData"});
        app.delete("/employee/:id", { controller: "em.EmployeeController", method: "deleteData"});
        return app.run();
    }
}
