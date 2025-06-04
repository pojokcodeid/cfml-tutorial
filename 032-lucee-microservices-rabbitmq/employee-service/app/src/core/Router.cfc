component {

    function begin() {
        app = new core.App();
        app.setDefaultController('Default');
        app.setDefaultControllerMethod('index');
        app.get('/user/test', {controller: 'em.UserController', method: 'test'});
        app.get('/user/send', {controller: 'em.UserController', method: 'sendMssage'});
        app.post('/user/register', {controller: 'em.UserController', method: 'register'});
        app.post('/user/login', {controller: 'em.UserController', method: 'login'});
        return app.run();
    }

}
