
component extends="core.BaseController" {
    variables.UserModel = model("em.UserModel");
    variables.rules = {
        name  : "required",
        email : "required|is_email",
        password: "required|strong_password"
    }

    public function init() {
        return this;
    }

    public any function sayHay(){
        var Password= new core.helpers.Password();
        var hash = Password.bcrypHashGet("123456");
        var verify = Password.bcryptHashVerify("123456", hash);
        var jwt = new core.helpers.Jwt();
        var token = jwt.encode({"name": "John Doe"});
        var veryfayAcess = jwt.decodeAccess(token.accessToken);
        var veryfayRefresh = jwt.decodeRefresh(token.refreshToken);
        var mail = new core.helpers.Mail(
            to="asep.010801503125082@gmail.com",
            from="info@mail.com",
            subject="Test Send Email",
            type="html"
        );
        mail.send("<h1>Test Send Email</h1>");
        return {
            code: 200,
            message: "success",
            hash: hash,
            verify: verify,
            accessToken: token.accessToken,
            refreshToken: token.refreshToken,
            veryfayAcess: veryfayAcess,
            veryfayRefresh: veryfayRefresh
        }
    }

    public struct function register(content={}){
        try{
            var result = validate(content, rules);
            if(not result.success){
                return {
                    success = false,
                    code = 400,
                    message = result.errors[1],
                    data = {}
                }
            }
            var Bcript = new core.helpers.Password();
            content.password = Bcript.bcrypHashGet(content.password);
            var registeredUser = UserModel.register(content);
            registeredUser.activate = application.baseURL&"/user/activate/"&registeredUser.uuid;
            var mail = new core.helpers.Mail(
                registeredUser.email,
                application.emailFrom,
                "Email Activation",
                "html"
            );
            mail.send(
                '<p>Hi #registeredUser.name#</p>
                <p>Click the link below to activate your account</p>
                <a href="#registeredUser.activate#">Activate</a>'
            );
            return {
                success = true,
                code = 201,
                message = "success",
                data = registeredUser
            }
        }catch (any e) {
            return {
                success = false,
                code = 422,
                message = e.message,
                data = {}
            }  
        }
    }
    
    public any function activate(uuid=""){
        try{
            if(!UserModel.activateStatus(uuid)){
                view("activation/index", { message:"Already Activated or Invalid UUID" });
                return false;
            }
            var result = UserModel.activate(uuid);  
            view("activation/index", { message:"Activation success" }); 
            return true;
        }catch (any e) {
             view("activation/index", { message:e.message });
            return false; 
        } 
    }

    public struct function login(content={}) {
        var loginRules = {
            email: "required|is_email",
            password: "required"
        };
        try {
            var result = validate(content, loginRules);
            if (!result.success) {
                return {
                    success = false,
                    code = 400,
                    message = result.errors[1],
                    data = {}
                };
            }

            var user = UserModel.login(content);
            var isValid = false;

            if (structKeyExists(user, "password")) {
                var Bcript = new core.helpers.Password();
                isValid = user.password = Bcript.bcryptHashVerify(content.password, user.password);
            } else {
                return {
                    success = false,
                    code = 401,
                    message = "User not found",
                    data = {}
                };
            }

            if (!isValid) {
                return {
                    success = false,
                    code = 401,
                    message = "Invalid Password",
                    data = {}
                };
            }

            user.password = "********";

            var Jwt = new core.helpers.Jwt();
            var token = Jwt.encode(user);
            cfcookie(
                name="refreshToken",
                value=token.refreshToken,
                path = "/user/refresh",
                expires=token.expiredRefresh,
                httponly=true,
                encodevalue=true,
                samesite="strict"
            );
            return {
                success = true,
                code = 200,
                message = "success",
                data = user,
                accessToken = token.accessToken
            };
        } catch (any e) {
            return {
                success = false,
                code = 422,
                message = e.message,
                data = {}
            };
        }
    }

    public any function refreshToken() {
        try {
            var authenticate = new core.helpers.Header();
            var auth = authenticate.authenticateRefresh();
            if(not isStruct(auth.DATA) && auth.DATA==false){
                return {
                    success = false,
                    code = 401,
                    message = auth.message,
                    data = {}
                };
            }
            var newToken = auth.token;
            cfcookie(
                name = "refreshToken",
                value = newToken.refreshToken,
                path = "/user/refresh",
                expires = newToken.expiredRefresh,
                httponly = true,
                encodevalue = true,
                samesite = "strict"
            );
            return {
                success = true,
                code = 200,
                message = "Token refreshed",
                data = auth.data,
                accessToken = newToken.accessToken
            };
        } catch (any e) {
            return {
                success = false,
                code = 422,
                message = e.message,
                data = {}
            };
        }
    }

    public struct function update(content={}){
        if(not structKeyExists(content, "password") ||content.password == ""){
            variables.rules = {
                name  : "required",
                email: "required|is_email"
            }
        }
        try{
            var authenticate = new core.helpers.Header();
            var auth = authenticate.authenticateAcess();
            if(not isStruct(auth.DATA) && auth.DATA==false){
                return {
                    success = false,
                    code = 401,
                    message = auth.message,
                    data = {}
                }
            }
            var result = validate(content, rules);
            if(not result.success){
                 return {
                    success = false,
                    code = 400,
                    message = result.errors[1],
                    data = {}
                }
            }
            if(structKeyExists(content, "password") && len(trim(content.password)) > 0){
                var Bcript = new core.helpers.Password();
                content.password = Bcript.bcrypHashGet(content.password);
            }
            content.user_id = auth.DATA.content.USERID;
            content.personal_id = auth.DATA.content.PERSONALID;
            var updatedUser = UserModel.update(content);
            updatedUser.password = "xxxxxxxxxxxxxxxxxx";
            return {
                success = true,
                code = 200,
                message = "success",
                data = updatedUser
            }
        }catch (any e) {
            return {
                success = false,
                code = 422,
                message = e.message,
                data = {}
            }
        }
    }
}