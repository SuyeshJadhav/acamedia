const { Router } = require("express");
const createChat = require("../controllers/chatController/createChat");
const { getChatId } = require( "../controllers/chatController/chatHelperFunctions" );
const getChatData = require( "../controllers/chatController/getChatData" );

const router = Router();

router.post("/create-chat", async (req, res) => {
  const { user1Id, user2Id } = req.body;
  const result = await createChat(user1Id, user2Id);
  res.send(result);
});

router.get("/get-chat-id", async (req, res) => {
  const {user1Id, user2Id} = req.body;
  const result = await getChatId(user1Id, user2Id);
  res.send(result);
});

router.get("/get-data", async (req,res) => {
  const {chatId, userId} = req.query;
  const result = await getChatData(chatId, userId);
  res.send(result);
});

module.exports = router;