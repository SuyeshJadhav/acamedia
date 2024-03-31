const initiateServer = (io) => {
  io.use((socket, next) => {
    const id = socket.handshake.auth.id;
    socket.id = id;
    next();
  });

  io.on("connection", (socket) => {
    // console.log(socket.rooms);
    // console.log(socket.id);
    // console.log("----------------");

    socket.on("join", (roomName) => {
      console.log(roomName);

      Array.from(socket.rooms)
        .filter((it) => it !== socket.id)
        .forEach((id) => {
          socket.leave(id);
          socket.removeAllListeners(`emitMessage`);
        });

      socket.join(roomName);
      // console.log(Array.from(socket.rooms));

      socket.on(`emitMessage`, (message) => {
        Array.from(socket.rooms)
          .filter((it) => it !== socket.id)
          .forEach((id) => {
            socket.to(id).emit("onMessage", message);
          });
      });
    });

    socket.on("onMessage", (msg) => {
      console.log(msg);
    });

    // socket.on("private message", ({ content, to }) => {
    //   console.log(to, content);
    //   socket.to(to).emit("private message", {
    //     content,
    //     from: socket.id,
    //   });
    // });

    socket.on("disconnect", () => {
      // console.log(socket.id + " ==== diconnected");
      socket.removeAllListeners();
    });
  });
};

module.exports = initiateServer;
