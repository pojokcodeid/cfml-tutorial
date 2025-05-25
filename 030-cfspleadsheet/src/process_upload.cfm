<cfscript>
    userController = new controllers.UserController();
    userController.uploadExcel();
    writeOutput('<br/><a href="/">Back to home</a>');  
</cfscript>
