component {

    function begin() {
        app = new core.App();
        app.setDefaultController('Default');
        app.setDefaultControllerMethod('index');
        app.post('/user/register', {controller: 'em.UserController', method: 'register'});
        app.get('/user/activate/:uuid', {controller: 'em.UserController', method: 'activate'});
        app.post('/user/login', {controller: 'em.UserController', method: 'login'});
        app.get('/user/refresh', {controller: 'em.UserController', method: 'refreshToken'});
        app.put('/user/update', {controller: 'em.UserController', method: 'update'});
        app.get('/user/logout', {controller: 'em.UserController', method: 'logout'});
        app.get('/user/callback', {controller: 'em.UserController', method: 'callback'});
        app.get('/user/login2', {controller: 'em.UserController', method: 'login2'});
        return app.run();
    }

}
