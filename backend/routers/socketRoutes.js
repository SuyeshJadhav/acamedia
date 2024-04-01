const { Router } = require("express");
const router = Router();
const path = require("path");

const {
  getUserDataById
} = require("../controllers/userController/userHelperFunctions");
const {
  getChatId
} = require("../controllers/chatController/chatHelperFunction");
const initiateServer = require("../socket/main");

router.get("/", (req, res) => {
  const indexPath = path.join(__dirname, "..", "views", "index.html");
  res.sendFile(indexPath);
});

router.post("/direct", async (req, res) => {
  const { sender_id, receiver_id } = req.body;
  // console.log(sender_id, receiver_id);
  const resp = await getUserDataById(receiver_id);
  // console.log(resp);
  const chatId = await getChatId(sender_id, receiver_id);
  return res.status(201).json({ message: "Received ID: " + chatId });
});

router.get("/direct/:id", async (req, res) => {
  const user1ID = "AXVw4MhGrTPqeAd0vuEG";
  const user2ID = req.params.id;
  console.log(user2ID);
  const chatId = await getChatId(user1ID, user2ID);
  console.log(chatId);
  res.send("hello");
});

module.exports = router;
