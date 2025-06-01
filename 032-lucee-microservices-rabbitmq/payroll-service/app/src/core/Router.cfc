component {

    function begin() {
        app = new core.App();
        app.setDefaultController('Default');
        app.setDefaultControllerMethod('index');
        app.get('/user/read', {controller: 'py.UserController', method: 'readMssage'});
        return app.run();
    }

}
