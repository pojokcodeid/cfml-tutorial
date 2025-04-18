<cfset service = new cfc.UserService()>

<cfoutput>
  <strong>Show Access (from UserService):</strong><br>
  #service.showAccess()#<br><br>

  <strong>Test Base Access (from BaseService):</strong><br>
  #service.testBaseAccess()#

  <p>Contoh Overide Function</p>
  #service.getUserRole(1)#<br>
  
  <!--- #service.packageMessage()# tidak bisa di acess jika beda folder--->
</cfoutput>
