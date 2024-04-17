const express = require("express");
const cors = require("cors");
const { Server } = require("socket.io");
const { createServer } = require("http");
require("dotenv").config();

const userRouter = require("./routers/userRouter");
const chatRouter = require("./routers/chatRouter");
const messageRouter = require("./routers/messageRouter");
const socketRouter = require("./routers/socketRoutes");
initiateServer = require("./socket/main");

const app = express();
app.use(
  cors({
    origin: "*"
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/user", userRouter);
app.use("/api/chat", chatRouter);
app.use("/api/message", messageRouter);
app.use("/api/socket", socketRouter);

const PORT = process.env.PORT || 8000;
// const server = app.listen(PORT, () => console.log(`Server is connected to port ${PORT}`));

const httpServer = createServer(app);

// const io = new Server(server);
// const io = new Server(httpServer);
const io = require("socket.io")(httpServer, {
  cors: {
    origin: "*"
  }
});

// const ip = "10.0.2.2";
// const ip = "127.0.0.1";
// , ip
httpServer.listen(PORT, () => {
  console.log(`Server is connected to port ${PORT}`);
});

initiateServer(io);
