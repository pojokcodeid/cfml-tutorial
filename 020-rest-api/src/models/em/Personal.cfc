component extends="../JwtMiddleware" restpath="/personal"  rest="true"{
  
    /**
     * @function getAllPersonal
     * @description Get all personal data
     * @param {void} 
     * @return {struct} - response data
     * @return {boolean} response.data.success - true or false
     * @return {string} response.data.message - message
     * @return {struct} response.data.data - data personal
     */
    remote struct function getAllPersonal() 
        httpmethod="GET" 
        restpath="" 
        produces="application/json"{
        // Verify the user's authentication token to ensure it is valid
        var verify = super.authenticate();
		if(not verify.success){
			cfheader(statusCode=401, statusText="Unauthorized");
			return {
				success = false,
				message = verify.message,
				data = {}
			};
		}
        // get all personaldata from database
        var qPersonal = queryExecute(
            "SELECT 
                p.id as personalId,
                p.name,
                p.email,
                p.age
            FROM personal p",
            {},
            { datasource = super.datasource }
        );
        // check return query, if record null return empty struct
        if(qPersonal.recordCount){
            var arrPersonal = [];
            for (var i = 1; i <= qPersonal.recordCount; i++) {
                arrPersonal[i] = {
                    personalId = qPersonal['personalId'][i],
                    name = qPersonal['name'][i],
                    email = qPersonal['email'][i],
                    age = qPersonal['age'][i]
                };
            }
            cfheader(statusCode=200, statusText="Ok");
            return {
                success = true,
                message = "Get all personal success",
                data = arrPersonal
            };
        }else{
            cfheader(statusCode=404, statusText="Not Found");
            return {
                success = false,
                message = "No data found",
                data = {}
            };
        }
    }

    private function getPersonalId(numeric userId){
        var qPersonal = queryExecute(
            "SELECT 
                p.id as personalId,
                p.name,
                p.email,
                p.age
            FROM personal p
            WHERE p.id = :userId",
            { userId: { value: userId,  cfsqltype: "cf_sql_integer" } },
            { datasource = super.datasource }
        );
        if (qPersonal.recordCount) {
            var personalData = {
                personalId = qPersonal['personalId'][1],
                name = qPersonal['name'][1],
                email = qPersonal['email'][1],
                age = qPersonal['age'][1]
            };
        }else{
            var personalData = {}
        }
        return personalData;
    }

    /**
     * @function getPersonalById
     * @description Get personal data by ID
     * @param {numeric} userId - ID of the user
     * @return {struct} - response data
     * @return {boolean} response.data.success - true or false
     * @return {string} response.data.message - message
     * @return {struct} response.data.data - data personal
     */
    remote struct function getPersonalById(numeric userId restargsource="path") 
        httpmethod="GET" 
        restpath="{userId}" 
        produces="application/json"{
       
        // Verify the user's authentication token to ensure it is valid
        var verify = super.authenticate();
        if (not verify.success) {
            cfheader(statusCode=401, statusText="Unauthorized");
            return {
                success = false,
                message = verify.message,
                data = {}
            };
        }
        
        // get personal data by userId from database
        var personal = getPersonalId(userId);

        // check return query, if record null return empty struct
        if (structKeyExists(personal, "personalId")) {
            cfheader(statusCode=200, statusText="Ok");
            return {
                success = true,
                message = "Get personal data success",
                data = personal
            };
        } else {
            cfheader(statusCode=404, statusText="Not Found");
            return {
                success = false,
                message = "No data found",
                data = {}
            };
        }
    }

    
    /**
     * @function updatePersonal
     * @description Update personal data
     * @param {numeric} userId - ID of the user
     * @param {struct} personalData - personal data
     * @return {struct} - response data
     * @return {boolean} response.data.success - true or false
     * @return {string} response.data.message - message
     */
    remote struct function updatePersonal(numeric userId restargsource="path", struct personalData ) 
        httpmethod="PUT" 
        restpath="{userId}" 
        produces="application/json"{
       
        // Verify the user's authentication token to ensure it is valid
        var verify = super.authenticate();
        if (not verify.success) {
            cfheader(statusCode=401, statusText="Unauthorized");
            return {
                success = false,
                message = verify.message,
                data = {}
            };
        }
        // check data exists or not 
        var personal = getPersonalId(userId);

        // check return query, if record null return empty struct
        if (not structKeyExists(personal, "personalId")) {
            cfheader(statusCode=404, statusText="Not Found");
            return {
                success = false,
                message = "No data found",
                data = {}
            };
        }
        // update personal data
        try{
            var qUpdate = queryExecute(
                "UPDATE personal SET 
                    name = :name, 
                    email = :email,
                    age = :age
                WHERE id = :userId",
                {
                    name: { value: personalData.name, cfsqltype: "cf_sql_varchar" },
                    email: { value: personalData.email, cfsqltype: "cf_sql_varchar" },
                    age: { value: personalData.age, cfsqltype: "cf_sql_integer" },
                    userId: { value: userId, cfsqltype: "cf_sql_integer" }
                },
                { datasource = super.datasource }
            );
            cfheader(statusCode=200, statusText="Ok");
            return {
                success = true,
                message = "Update personal data success",
                data = personal
            };
        }catch (exType exName) {
            cfheader(statusCode=500, statusText="Internal server error");
            return {
                success = false,
                message = "Internal server error",
                data = {}
            };
        }
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
     * @function createPersonal
     * @description Create new personal data
     * @param {struct} personalData - personal data to be created
     * @return {struct} - response data
     * @return {boolean} response.data.success - true or false
     * @return {string} response.data.message - message
     */
    remote struct function createPersonal(struct personalData) 
        httpmethod="POST" 
        restpath="" 
        produces="application/json"{

        // Verify the user's authentication token to ensure it is valid
        var verify = super.authenticate();
        if (not verify.success) {
            cfheader(statusCode=401, statusText="Unauthorized");
            return {
                success = false,
                message = verify.message,
                data = {}
            };
        }

        // check email already or not
        if (emailAlreadyExists(personalData.email)) {
            cfheader(statusCode=409, statusText="Conflict");
            return {
                success = false,
                message = "Email already registered",
                data = {}
            };
        }

        // Create new personal data
        try {
            var qInsert = queryExecute(
                "INSERT INTO personal (name, email, age) VALUES (:name, :email, :age)",
                {
                    name: { value: personalData.name, cfsqltype: "cf_sql_varchar" },
                    email: { value: personalData.email, cfsqltype: "cf_sql_varchar" },
                    age: { value: personalData.age, cfsqltype: "cf_sql_integer" }
                },
                { datasource = super.datasource }
            );
            cfheader(statusCode=201, statusText="Created");
            return {
                success = true,
                message = "Create personal data success",
                data = personalData
            };
        } catch (exType exName) {
            cfheader(statusCode=500, statusText="Internal server error");
            return {
                success = false,
                message = "Internal server error",
                data = {}
            };
        }
    }

    
    /**
     * @function deletePersonal
     * @description Delete personal data by ID
     * @param {numeric} userId - ID of the user
     * @return {struct} - response data
     * @return {boolean} response.data.success - true or false
     * @return {string} response.data.message - message
     */
    remote struct function deletePersonal(numeric userId restargsource="path") 
        httpmethod="DELETE" 
        restpath="{userId}" 
        produces="application/json"{
       
        // Verify the user's authentication token to ensure it is valid
        var verify = super.authenticate();
        if (not verify.success) {
            cfheader(statusCode=401, statusText="Unauthorized");
            return {
                success = false,
                message = verify.message,
                data = {}
            };
        }

        // check data exists or not 
        var personal = getPersonalId(userId);

        // check return query, if record null return empty struct
        if (not structKeyExists(personal, "personalId")) {
            cfheader(statusCode=404, statusText="Not Found");
            return {
                success = false,
                message = "No data found",
                data = {}
            };
        }
        // delete personal data
        try {
            var qDelete = queryExecute(
                "DELETE FROM personal WHERE id = :userId",
                {
                    userId: { value: userId,  cfsqltype: "cf_sql_integer" }
                },
                { datasource = super.datasource }
            );
            cfheader(statusCode=200, statusText="Ok");
            return {
                success = true,
                message = "Delete personal data success",
                data = personal
            };
        } catch (exType exName) {
            cfheader(statusCode=500, statusText="Internal server error");
            return {
                success = false,
                message = "Internal server error",
                data = {}
            };
        }
    }

}