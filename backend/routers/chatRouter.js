const { Router } = require("express");
const createChat = require("../controllers/chatController/createChat");
const { getChatId } = require( "../controllers/chatController/chatHelperFunctions" );

const router = Router();

router.post("/create-chat", async (req, res) => {
  const { user1Id, user2Id } = req.body;
  const result = await createChat(user1Id, user2Id);
  res.send(result);
});

router.get("/get-chat-id", async (req, res) => {
  const {user1Id, user2Id} = req.body;
  const result = await getChatId(user1Id, user2Id);
  res.send({chatId: result});
});

module.exports = router;