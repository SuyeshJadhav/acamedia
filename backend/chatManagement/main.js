const initiateServer = (io) => {
  io.use((socket, next) => {
    const username = socket.handshake.auth.username;
    if (!username) {
      return next(new Error("invalid username"));
    }
    console.log(username);
    socket.username = username;
    next();
  });

  io.on("connection", (socket) => {
    socket.broadcast.emit("user connected", {
      userID: socket.id,
      username: socket.username,
    });
    const users = [];
    for (let [id, socket] of io.of("/").sockets) {
      users.push({
        userID: id,
        username: socket.username,
      });
    }
    socket.emit("users", users);

    socket.on("private message", ({ content, to }) => {
      console.log(to, content);
      socket.to(to).emit("private message", {
        content,
        from: socket.id,
      });
    });
    // ...
  });
};

module.exports = initiateServer;
