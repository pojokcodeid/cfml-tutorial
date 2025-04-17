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
		var passwordUtil = new helpers.Password();
		var newUser = user;
		newUser.password = passwordUtil.bcryptHashGet(newUser.password);
		
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
			transaction action="begin" {
				// process insert personal
				var qInsert = queryExecute(
					"INSERT INTO personal (
						name,
						email,
						age
					) VALUES (
						:name,
						:email,
						:age
					)",
					{
						name = { value = newUser.name, sqltype = "CF_SQL_VARCHAR" },
						email = { value = newUser.email, sqltype = "CF_SQL_VARCHAR" },
						age = { value = newUser.age, sqltype = "CF_SQL_NUMERIC" }
					},
					{ datasource = super.datasource, result = "local.lastInsert" }
				);
				var insertedId = local.lastInsert.generatedKey;
				// insert ke  user 
				var qInsertUser = queryExecute(
					"INSERT INTO user (
						username,
						password,
						role,
						status,
						personal_id
					) VALUES (
						:username,
						:password,
						:role,
						:status,
						:personal_id
					)",
					{
						username = { value = newUser.email, sqltype = "CF_SQL_VARCHAR" },
						password = { value = newUser.password, sqltype = "CF_SQL_VARCHAR" },
						role = { value = "user", sqltype = "CF_SQL_VARCHAR" },
						status = { value = 1, sqltype = "CF_SQL_NUMERIC" },
						personal_id = { value = insertedId, sqltype = "CF_SQL_NUMERIC" }
					},
					{ datasource = super.datasource }
				);			
			}
			// change password before return 
			newUser.password="xxxxxxxxxxxxxxxxxxx";
			// addUserToStorage(newUser);
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
			"SELECT id FROM personal where email = :email",
			{
				email = {value=email, sqltype="CF_SQL_VARCHAR"}
			},
			{
				datasource: super.datasource
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
		local.qPersonal = queryExecute(
			"SELECT id FROM personal where email = :email",
			{
				email = {value="Test@email.com", sqltype="CF_SQL_VARCHAR"}
			},
			{
				datasource: super.datasource
			}
		);
		return {
			success= true,
			message= "Login Success",
			application = serializeJSON( application ),
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