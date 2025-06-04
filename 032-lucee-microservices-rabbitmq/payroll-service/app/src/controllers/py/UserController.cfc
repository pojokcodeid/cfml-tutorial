component extends="core.BaseController" {

    variables.UserModel = model('em.UserModel');
    variables.rules = {name: 'required', email: 'required|is_email', password: 'required|strong_password'}

    public function init() {
        return this;
    }

    public any function test(){
        var password = new core.helpers.Password();
        var hash = password.bcryptHashGet('password');
        var jwt = new core.helpers.Jwt();
        var token= jwt.encode({username: 'pojokcode'});
        return {code: 200, message: 'Success', data: token};
    }

    public any function sendMssage() {
        var rabbit = new core.helpers.RabbitMQ().init();
        var data = {
            id: 3,
            name: 'Pojok Code',
            message: 'Halo dari Lucee!',
            timestamp: now()
        }

        // Encode menjadi JSON
        var jsonMessage = serializeJSON(data);

        // Kirim JSON ke queue
        var result = rabbit.sendMessage('testQueue2', jsonMessage);
        rabbit.close();

        return {code: 200, message: 'Success', data: deserializeJSON(result)};
    }

    public struct function update(content = {}) {
        if (not structKeyExists(content, 'password') || content.password == '') {
            variables.rules = {name: 'required', email: 'required|is_email'}
        }
        try {
            var authenticate = new core.helpers.Header();
            var auth = authenticate.authenticateAcess();
            if (not isStruct(auth.DATA) && auth.DATA == false) {
                return {
                    success: false,
                    code: 401,
                    message: auth.message,
                    data: {}
                }
            }
            var result = validate(content, rules);
            if (not result.success) {
                return {
                    success: false,
                    code: 400,
                    message: result.errors[1],
                    data: {}
                }
            }
            return {
                success: true,
                code: 200,
                message: 'success',
                data: {}
            }
        } catch (any e) {
            return {
                success: false,
                code: 422,
                message: e.message,
                data: {}
            }
        }
    }

}
