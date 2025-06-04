component {

    function begin() {
        app = new core.App();
        app.setDefaultController('Default');
        app.setDefaultControllerMethod('index');
        app.get('/auth/user/test', {controller: 'em.UserController', method: 'test'});
        app.get('/auth/user/send', {controller: 'em.UserController', method: 'sendMssage'});
        app.post('/auth/user/register', {controller: 'em.UserController', method: 'register'});
        app.post('/auth/user/login', {controller: 'em.UserController', method: 'login'});
        app.get('/auth/user/refresh', {controller: 'em.UserController', method: 'refreshToken'});
        return app.run();
    }

}
