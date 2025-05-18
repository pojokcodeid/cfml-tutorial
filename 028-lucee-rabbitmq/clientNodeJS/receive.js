const amqp = require("amqplib");

const queue = "testQueue2";

async function receiveMessage() {
  try {
    // Koneksi ke RabbitMQ
    const connection = await amqp.connect("amqp://localhost");
    const channel = await connection.createChannel();

    // Pastikan queue ada (dengan type quorum kalau ingin disamakan)
    await channel.assertQueue(queue, {
      durable: true,
      arguments: {
        "x-queue-type": "quorum", // Hanya jika kamu memang pakai quorum queue
      },
    });

    console.log(`Menunggu pesan dari queue: ${queue}...`);

    channel.consume(queue, (msg) => {
      if (msg !== null) {
        const content = msg.content.toString();
        console.log("Pesan diterima:", content);

        // Jika pesan berupa JSON, bisa parse:
        try {
          const data = JSON.parse(content);
          console.log("Data parsed:", data);
        } catch (e) {
          console.error("Bukan JSON valid:", e.message);
        }

        // Tandai pesan sebagai selesai diproses
        channel.ack(msg);
      }
    });
  } catch (err) {
    console.error("Gagal menerima pesan:", err);
  }
}

receiveMessage();
