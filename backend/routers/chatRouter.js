const { Router } = require("express");
const createChat = require("../controllers/chatController/createChat");
const { storeMessage, deleteMessage } = require("../controllers/chatController/messageManagement");
const { getChatId } = require( "../controllers/chatController/chatHelperFunction" );

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

router.get("/get-chat-id", async (req, res) => {
  const {user1Id, user2Id} = req.body;
  const result = await getChatId(user1Id, user2Id);
  res.send({chatId: result});
});

module.exports = router;