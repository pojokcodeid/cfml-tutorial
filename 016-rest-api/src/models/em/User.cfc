component extends="../jwtMiddleware" restpath="/user"  rest="true" {

  remote struct function sayHay() httpmethod="GET" restpath="say" {
    local.data = {}
    var verify = super.authenticate();
    if(not verify.success){
      // content if invalid token
      cfheader(statusCode=401, statusText=verify.message);
    }else{
      // content if valid token
      cfheader(statusCode=200, statusText="Ok");
    }
    return { 
      success=verify.success,
      message=verify.message, 
      data=local.data
    };
  }

  remote struct function login()  httpmethod="GET" restpath="login" {
    var result = super.generate("Pojok Code");
    cfheader(statusCode=200, statusText="ok");
    return {
      success= true,
      message= "Login Success",
      data = {
        id=1,
        name="Pojok Code",
        email="email@gmail.com"
      },
      accessToken = result.accessToken,
      refreshToken = result.refreshToken
    }
  }
}