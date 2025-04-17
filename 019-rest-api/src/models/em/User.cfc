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

	remote struct function register(struct user) httpmethod="POST" restpath="register" {
		var response = {};
		var newUser = user;
		newUser.id = createUUID();
		newUser.password = hash(newUser.password, "SHA-256");
		
		// Assuming you have some kind of user storage, e.g., a database or an in-memory structure
		// Here we just simulate adding a user
		if (emailAlreadyExists(newUser.email)) {
		cfheader(statusCode=409, statusText="Conflict");
		response = {
			success = false,
			message = "Email already registered",
			data = {}
		};
		} else {
		// Simulate storing the new user
		addUserToStorage(newUser);
		cfheader(statusCode=201, statusText="Created");
		response = {
			success = true,
			message = "User registered successfully",
			data = newUser
		};
		}
		
		return response;
	}
  
	// Placeholder function to check if email already exists
	private boolean function emailAlreadyExists(string email) {
		local.qPersonal = queryExecute(
			"SELECT personal_id FROM personal where email = :email",
			{
				email = {value=email, sqltype="CF_SQL_VARCHAR"}
			}
		);
		if(local.qPersonal.recordCount){
			return true;
		}else{
			return false;
		}
	}

	// Placeholder function to add user to storage
	private void function addUserToStorage(struct user) {
		// Implement actual storage logic here
	}


	remote struct function login()  httpmethod="GET" restpath="login" {
		var passwordUtil = new helpers.Password();
		var result = super.generate("Pojok Code");
  		var hashedPassword = passwordUtil.bcryptHashGet("userPassword123!");
		cfheader(statusCode=200, statusText="ok");
		return {
		success= true,
		message= "Login Success",
		data = {
			id=1,
			name="Pojok Code",
			email="email@gmail.com",
			pass = hashedPassword
		},
		accessToken = result.accessToken,
		refreshToken = result.refreshToken
		}
	}
}