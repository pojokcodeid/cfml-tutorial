
component extends="core.BaseController" {
    variables.UserModel = model("em.UserModel");
    variables.rules = {
        name  : "required",
        email: "required|is_email",
        password: "required|strong_password"
    }

    public function init() {
        return this;
    }

    public any function readMssage(){
        try{
            var rabbit= new core.helpers.RabbitMQ().init();
            var msg = rabbit.receiveMessage("testQueue2");
            rabbit.close();
    
            return {
                code: 200,
                message: "Success",
                data: deserializeJSON(msg)
            };
        }catch (any e) {
            return {
                code: 500,
                message: "Error",
                data: e.message
            };
        }
    }
  
}