const { Router } = require("express");
const createChat = require("../chatManagement/createChat");
const { storeMessage, deleteMessage } = require("../chatManagement/messageManagement");

const router = Router();

router.post("/create-chat", async (req, res) => {
  const { user1Id, user2Id } = req.body;
  const result = await createChat(user1Id, user2Id);
  res.send(result);
});

router.post("/send-message", async (req, res) => {
  const { senderId, chatId, message } = req.body;
  const result = await storeMessage(senderId, chatId, message);
  res.send(result);
});

router.delete("/delete-message", async (req, res) => {
  const { senderId, chatId, messageId } = req.body;
  const result = await deleteMessage(senderId, chatId, messageId);
  res.send(result);
});

module.exports = router;