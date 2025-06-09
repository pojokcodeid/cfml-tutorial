module.exports = {
  apps: [
    {
      name: "worker",
      script: "./index.js",
      instances: 1,
      exec_mode: "fork", // Ubah ke "cluster" jika ingin multi-core
      watch: false,
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};
