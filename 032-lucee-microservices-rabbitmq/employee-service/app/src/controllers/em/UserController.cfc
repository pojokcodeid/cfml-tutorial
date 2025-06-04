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

    public struct function register(content = {}) {
        try {
            var result = validate(content, rules);
            if (not result.success) {
                return {
                    success: false,
                    code: 400,
                    message: result.errors[1],
                    data: {}
                }
            }
            var Bcript = new core.helpers.Password();
            content.password = Bcript.bcryptHashGet(content.password);
            var registeredUser = UserModel.register(content);
            registeredUser.activate = application.baseURL & '/user/activate/' & registeredUser.uuid;
            var mail = new core.helpers.Mail(
                registeredUser.email,
                application.emailFrom,
                'Email Activation',
                'html'
            );
            mail.send(
                '<p>Hi #registeredUser.name#</p>
                <p>Click the link below to activate your account</p>
                <a href="#registeredUser.activate#">Activate</a>'
            );
            return {
                success: true,
                code: 201,
                message: 'success',
                data: registeredUser
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

        public struct function login(content = {}) {
        var loginRules = {email: 'required|is_email', password: 'required'};
        try {
            var result = validate(content, loginRules);
            if (!result.success) {
                return {
                    success: false,
                    code: 400,
                    message: result.errors[1],
                    data: {}
                };
            }

            var user = UserModel.login(content);
            var isValid = false;

            if (structKeyExists(user, 'password')) {
                var Bcript = new core.helpers.Password();
                isValid = user.password = Bcript.bcryptHashVerify(content.password, user.password);
            } else {
                return {
                    success: false,
                    code: 401,
                    message: 'User not found',
                    data: {}
                };
            }

            if (!isValid) {
                return {
                    success: false,
                    code: 401,
                    message: 'Invalid Password',
                    data: {}
                };
            }

            user.password = '********';

            var Jwt = new core.helpers.Jwt();
            var token = Jwt.encode(user);
            cfcookie(
                name = "accessToken",
                value = token.accessToken,
                path = "/",
                expires = token.expiredAccess,
                httponly = true,
                encodevalue = true,
                // secure=true,
                samesite = "strict"
            );
            cfcookie(
                name = "refreshToken",
                value = token.refreshToken,
                path = "/user/refresh",
                expires = token.expiredRefresh,
                httponly = true,
                encodevalue = true,
                // secure=true,
                samesite = "strict"
            );
            return {
                success: true,
                code: 200,
                message: 'success',
                data: user
            };
        } catch (any e) {
            return {
                success: false,
                code: 422,
                message: e.message,
                data: {}
            };
        }
    }

}
