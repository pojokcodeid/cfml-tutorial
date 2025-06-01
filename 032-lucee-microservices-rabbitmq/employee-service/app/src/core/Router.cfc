component {

    function begin() {
        app = new core.App();
        app.setDefaultController("Default");
        app.setDefaultControllerMethod("index");
        app.get("/user/send", { controller: "em.UserController", method: "sendMssage"});
        return app.run();
    }
}
