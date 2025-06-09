const amqp = require("amqplib");

const queues = ["testQueue2", "paymentQueue", "logQueue"];

async function receiveMessages() {
  try {
    const connection = await amqp.connect("amqp://guest:guest@rabbitmq:5672");
    const channel = await connection.createChannel();

    for (const queue of queues) {
      await channel.assertQueue(queue, {
        durable: true,
        arguments: {
          "x-queue-type": "quorum", // Jika semua pakai quorum
        },
      });

      console.log(`✅ Menunggu pesan dari queue: ${queue}`);

      channel.consume(
        queue,
        (msg) => {
          if (msg !== null) {
            const content = msg.content.toString();
            console.log(`📥 [${queue}] Pesan diterima:`, content);

            try {
              const data = JSON.parse(content);
              // Di sini kamu bisa tambahkan handler khusus per queue
              handleQueueMessage(queue, data);
            } catch (e) {
              console.error(`[${queue}] ❌ Bukan JSON valid:`, e.message);
            }

            channel.ack(msg);
          }
        },
        {
          noAck: false,
        }
      );
    }
  } catch (err) {
    console.error("❌ Gagal menerima pesan:", err.message);
    setTimeout(receiveMessages, 5000); // Retry auto jika gagal
  }
}

function handleQueueMessage(queue, data) {
  switch (queue) {
    case "testQueue2":
      console.log("🔧 Update data dari testQueue2:", data);
      break;
    case "paymentQueue":
      console.log("💰 Payment handler:", data);
      break;
    case "logQueue":
      console.log("📝 Log data handler:", data);
      break;
    default:
      console.warn(`⚠️ Tidak ada handler untuk queue: ${queue}`);
  }
}

receiveMessages();
