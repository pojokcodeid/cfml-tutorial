
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

    public any function sendMssage(){
        var rabbit= new core.helpers.RabbitMQ().init();
        var data = {
            id = 1,
            name = "Pojok Code",
            message = "Halo dari Lucee!",
            timestamp = now()
        }

        // Encode menjadi JSON
        var jsonMessage = serializeJSON(data);

        //Kirim JSON ke queue
        var result= rabbit.sendMessage("testQueue2", jsonMessage);
        rabbit.close();

        return {
            code: 200,
            message: "Success",
            data: deserializeJSON(result)
        };
    }
  
}