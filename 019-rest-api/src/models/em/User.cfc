component extends="../JwtMiddleware" restpath="/user"  rest="true" {

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
			// application=serializeJSON( application ),
			success=verify.success,
			message=verify.message, 
			data=local.data
		};
	}

	/**
	 * Function to register a user
	 * @function register
	 * @param {struct} user A struct containing the user's information
	 * @return {struct} A struct containing the response data
	 * @example
	 * {
	 * 	name: "John Doe",
	 * 	email: "john.doe@example.com",
	 * 	username: "johndoe",
	 * 	password: "P@ssw0rd",
	 * 	age: 30
	 * }
	 */
	remote struct function register(struct user) httpmethod="POST" restpath="register" {
		var passwordUtil = new helpers.Password();
		var newUser = user;
		// check email already or not
		if (emailAlreadyExists(newUser.email)) {
			cfheader(statusCode=409, statusText="Conflict");
			return {
				success = false,
				message = "Email already registered",
				data = {}
			};
		}
		newUser.password = passwordUtil.bcryptHashGet(newUser.password);
		// start insert data
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
			// insert data user 
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
					username = { value = newUser.username, sqltype = "CF_SQL_VARCHAR" },
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
		return {
			success = true,
			message = "User registered successfully",
			data = newUser
		};
	}
  
	/**
	 * Check if email already registered
	 * @function emailAlreadyExists
	 * @param {string} email an email to check
	 * @return {boolean} true if email already registered, false if not
	 */
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

	/**
	 * Retrieves user data based on the provided username.
	 * This function performs a database query to fetch details of a user,
	 * including their ID, username, password, role, status, and associated
	 * personal information such as name, email, and age.
	 *
	 * @function getUserByUsername
	 * @param {string} username The username of the user to retrieve.
	 * @return {struct} A struct containing the user data if found, otherwise an empty struct.
	 */
	private struct function getUserByUsername(string username) {
		local.qUser = queryExecute(
			"SELECT user.id, user.username, user.password, user.role, user.status, personal.name, personal.email, personal.age 
			FROM user 
			INNER JOIN personal ON user.personal_id = personal.id 
			WHERE user.username = :username",
			{
				username = {value=username, sqltype="CF_SQL_VARCHAR"}
			},
			{
				datasource: super.datasource
			}
		);
		if(local.qUser.recordCount){
			return {
				id = local.qUser.id,
				username = local.qUser.username,
				password = local.qUser.password,
				role = local.qUser.role,
				status = local.qUser.status,
				name = local.qUser.name,
				email = local.qUser.email,
				age = local.qUser.age
			};
		}else{
			return {};
		}
	}
	
	/**
	 * Login a user
	 * @function login
	 * @param {struct} user A struct containing the user's username and password
	 * @return {struct} A struct containing the response data
	 * @example
	 * {
	 * 	username: "johndoe",
	 * 	password: "P@ssw0rd"
	 * }
	 */
	remote struct function login(struct user)  httpmethod="POST" restpath="login" {
		var passwordUtil = new helpers.Password();
		var newUser = user;
		// get user by username
		var userData = getUserByUsername(newUser.username);
		if (structKeyExists(userData, "id")) {
			if (not passwordUtil.bcryptHashVerify(newUser.password, userData.password)) {
				cfheader(statusCode=401, statusText="Unauthorized");
				return {
					success = false,
					message = "Invalid password",
					data = {}
				};
			}
		} else {
			cfheader(statusCode=404, statusText="Not Found");
			return {
				success = false,
				message = "User not found",
				data = {}
			};
		}
		userData.password="xxxxxxxxxxxxxxxxxxxxxxx";
		var result = super.generate(userData);
		cfheader(statusCode=200, statusText="ok");		
		return {
			success= true,
			message= "Login Success",
			data = userData,
			accessToken = result.accessToken,
			refreshToken = result.refreshToken
		}
	}

	/**
	 * Refreshes the user's authentication tokens.
	 * This function validates the provided refresh token and generates a new
	 * access token and refresh token if the validation is successful.
	 * 
	 * @function refreshToken
	 * @return {struct} A struct containing the success status, message, user data,
	 *                  and the newly generated tokens if successful.
	 */
	remote struct function refreshToken() httpmethod="POST" restpath="refresh" {
		var response = {};
		var verify = authenticateRefresh();
		if(not verify.success){
			cfheader(statusCode=401, statusText="Unauthorized");
			response = {
				success = false,
				message = verify.message,
				data = {}
			};
		}else{
			cfheader(statusCode=200, statusText="Ok");
			var result = super.generate(verify.payload.DATA);
			response = {
				success = true,
				message = "Refresh token success",
				data = verify.payload.DATA,
				accessToken = result.accessToken,
				refreshToken = result.refreshToken
			};
		}
		return response;
	}

	/**
	 * Updates a user's data.
	 * This function validates the provided user data and performs an update
	 * to the user's record in the database if the validation is successful.
	 * 
	 * @function updateUser
	 * @param {struct} user A struct containing the user's data to update.
	 * @return {struct} A struct containing the response data.
	 */
	remote struct function updateUser(struct user) httpmethod="PUT" restpath="update" {
		var verify = super.authenticate();
		if(not verify.success){
			cfheader(statusCode=401, statusText="Unauthorized");
			return {
				success = false,
				message = verify.message,
				data = {}
			};
		}else{
			cfheader(statusCode=200, statusText="Ok");
			var passwordUtil = new helpers.Password();
			var newUser = user;
			var userData = getUserByUsername(newUser.oldUsername);
			if (structKeyExists(userData, "id")) {
				if ( not passwordUtil.bcryptHashVerify(newUser.oldPassword, userData.password)) {
					cfheader(statusCode=401, statusText="Unauthorized");
					return {
						success = false,
						message = "Invalid password",
						data = {}
					};
				}
			} else {
				cfheader(statusCode=404, statusText="Not Found");
				return {
					success = false,
					message = "User not found",
					data = {}
				};
			}
			if (structKeyExists(newUser, "username") and newUser.username != userData.username) {
				local.qUpdate = queryExecute(
					"UPDATE user SET username = :username WHERE id = :id",
					{
						username = { value = newUser.username, sqltype = "CF_SQL_VARCHAR" },
						id = { value = userData.id, sqltype = "CF_SQL_NUMERIC" }
					},
					{ datasource = super.datasource }
				);
			}
			if (structKeyExists(newUser, "password") and newUser.password != "") {
				local.qUpdate = queryExecute(
					"UPDATE user SET password = :password WHERE id = :id",
					{
						password = { value = passwordUtil.bcryptHashGet(newUser.password), sqltype = "CF_SQL_VARCHAR" },
						id = { value = userData.id, sqltype = "CF_SQL_NUMERIC" }
					},
					{ datasource = super.datasource }
				);
			}
			var dataReturn = userData;
			dataReturn.oldPassword="xxxxxxxxxxxxxxxxxxxxxxx";
			dataReturn.password="xxxxxxxxxxxxxxxxxxxxxxx";
			dataReturn.oldUsername=newUser.oldUsername;
			dataReturn.username=newUser.username;
			return {
				success = true,
				message = "Update user success",
				data = dataReturn
			};
		}
	}
}