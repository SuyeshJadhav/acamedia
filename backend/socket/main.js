const {
  storeMessage,
} = require("../controllers/messageController/messageManagement");

const initiateServer = (io) => {
  // io.use((socket, next) => {
  //   // For Socket.IO v2.x, authentication data is not available directly in handshake
  //   // You may need to pass the id in a different way, such as query parameters or custom headers
  //   // Example: const id = socket.handshake.query.id;
  //   // Replace 'id' with the key you're using to pass the authentication data
  //   const id = socket.handshake.query.id; // Assuming id is passed as a query parameter
  //   socket.id = id;
  //   next();
  // });

  io.on("connection", (socket) => {
    socket.on("join", (roomName) => {
      // console.log(roomName);
      // Remove listeners and leave rooms when joining a new room
      // Object.keys(socket.rooms)
      //   .filter((room) => room !== socket.id)
      //   .forEach((room) => {
      //     socket.leave(room);
      //     socket.removeAllListeners(`emitMessage`);
      //   });

      socket.join(roomName);
      socket.on(`emitMessage`, (message) => {
        // console.log(roomName);
        // console.log(message);
        storeMessage(message.sender, roomName, message.message);
        // Emit message to all clients in the room except the sender
        socket.to(roomName).emit("onMessage", message);
      });
    });

    socket.on("disconnect", () => {
      // Remove all listeners when a client disconnects
      Object.keys(socket.rooms)
        .filter((room) => room !== socket.id)
        .forEach((room) => {
          socket.leave(room);
          socket.removeAllListeners(`emitMessage`);
        });
    });
  });
};

module.exports = initiateServer;
