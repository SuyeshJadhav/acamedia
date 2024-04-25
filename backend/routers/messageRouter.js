const { Router } = require("express");
const checkMessageValidity = require( "../controllers/messageController/messageValidity" );
const { deleteMessage, storeMessage } = require( "../controllers/messageController/messageManagement" );
const router = Router();

router.post("/send", async (req, res) => {
  const { senderId, senderRole, receiverRole, chatId, message } = req.body;
  const result = await storeMessage(senderId, senderRole, receiverRole, chatId, message);
  res.send(result);
});

router.delete("/delete", async (req, res) => {
  const { senderId, chatId, messageId } = req.body;
  const result = await deleteMessage(senderId, chatId, messageId);
  res.send(result);
});

router.post("/prompt", async(req,res) => {
  const {message, role} = req.body;
  const result = await checkMessageValidity(message, role);
  res.send(result);
});

module.exports = router;