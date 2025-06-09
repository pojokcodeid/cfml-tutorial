const amqp = require("amqplib");
const axios = require("axios");

const queues = ["user/update"];
const RABBITMQ_URL = "amqp://guest:guest@rabbitmq:5672";
const API_BASE_URL = "http://payroll-service:8082";

// Retry utility
async function callApiWithRetry(queue, data, retries = 3, delayMs = 1000) {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      const response = await axios.put(
        `${API_BASE_URL}/payroll/${queue}`,
        data
      );
      console.log(`✅ [${queue}] API berhasil dipanggil`);
      return response.data;
    } catch (error) {
      console.error(
        `❌ [${queue}] Gagal panggil API (attempt ${attempt}):`,
        error.message
      );
      if (attempt < retries) {
        await new Promise((res) => setTimeout(res, delayMs));
      } else {
        throw new Error(`[${queue}] Semua retry gagal`);
      }
    }
  }
}

async function receiveMessages() {
  try {
    const connection = await amqp.connect(RABBITMQ_URL);
    const channel = await connection.createChannel();

    for (const queue of queues) {
      await channel.assertQueue(queue, {
        durable: true,
        arguments: {
          "x-queue-type": "quorum",
        },
      });

      console.log(`✅ Menunggu pesan dari queue: ${queue}...`);

      channel.consume(
        queue,
        async (msg) => {
          if (msg !== null) {
            const content = msg.content.toString();
            console.log(`📥 [${queue}] Pesan diterima:`, content);

            try {
              const data = JSON.parse(content);

              // Call CFML API with retry
              await callApiWithRetry(queue, data);

              // Jika sukses, ACK
              channel.ack(msg);
            } catch (err) {
              console.error(`❌ [${queue}] Gagal proses pesan:`, err.message);

              // Jangan ack = RabbitMQ akan retry otomatis (quorum queue behavior)
              // channel.nack(msg, false, true); // Optional manual retry if needed
            }
          }
        },
        {
          noAck: false,
        }
      );
    }
  } catch (err) {
    console.error("❌ Gagal koneksi ke RabbitMQ:", err.message);
    // Retry koneksi setelah 5 detik
    setTimeout(receiveMessages, 5000);
  }
}

receiveMessages();
