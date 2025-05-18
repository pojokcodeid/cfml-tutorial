<cfset rabbit = new RabbitMQ().init()>

<!--- Buat objek struktur (bisa juga array/complex) --->
<cfset data = {
  id = 1,
  name = "Pojok Code",
  message = "Halo dari Lucee!",
  timestamp = now()
}>

<!--- Encode menjadi JSON --->
<cfset jsonMessage = serializeJSON(data)>

<!--- Kirim JSON ke queue --->
<cfset rabbit.sendMessage("testQueue2", jsonMessage)>

<cfset rabbit.close()>

<cfoutput>Pesan JSON telah dikirim ke RabbitMQ</cfoutput>
