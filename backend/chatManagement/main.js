const initiateServer = (io) => {
  io.on("connection", (socket) => {
    console.log("User Connected- ", socket.id);

    socket.on("disconnect", (socket) => {
      console.log("user disconnected ");
    });

    socket.on("chat message", (msg) => {
      console.log("message: " + msg);
    });

    socket.on("chat message", (msg) => {
      io.emit("chat message", msg);
    });
  });
};

module.exports = initiateServer;
