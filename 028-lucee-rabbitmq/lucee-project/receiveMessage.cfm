<cfset rabbit = new RabbitMQ().init()>
<cfset msg = rabbit.receiveMessage("testQueue2")>
<cfoutput>#msg#</cfoutput>
<cfset rabbit.close()>
