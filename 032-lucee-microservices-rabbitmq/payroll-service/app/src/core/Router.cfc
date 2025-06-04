component {

    function begin() {
        app = new core.App();
        app.setDefaultController('Default');
        app.setDefaultControllerMethod('index');
        app.get('/payroll/user/test', {controller: 'py.UserController', method: 'test'});
        app.put('/payroll/user/update', {controller: 'py.UserController', method: 'update'});
        return app.run();
    }

}
