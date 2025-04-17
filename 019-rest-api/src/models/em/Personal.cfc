component extends="../JwtMiddleware" restpath="/personal"  rest="true"{
  
    remote struct function getAllPersonal() httpmethod="GET" restpath="" {
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
        var qPersonal = queryExecute(
            "SELECT 
                u.id as userId,
                u.username,
                u.role,
                u.status,
                p.id as personalId,
                p.name,
                p.email,
                p.age
            FROM user u 
            INNER JOIN personal p ON u.personal_id = p.id",
            {},
            { datasource = super.datasource }
        );
        if(qPersonal.recordCount){
            cfheader(statusCode=200, statusText="Ok");
            return {
                success = true,
                message = "Get all personal success",
                data = qPersonal
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
}