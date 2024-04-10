const { Router } = require("express");
const createChat = require("../controllers/chatController/createChat");
const {
  getChatId
} = require("../controllers/chatController/chatHelperFunctions");
const getChatData = require("../controllers/chatController/getChatData");
const { statusCodes } = require("../utils/variableNames");

const router = Router();

router.post("/create", async (req, res) => {
  const { user1Id, user2Id } = req.body;
  const result = await createChat(user1Id, user2Id);
  res.send(result);
});

router.get("/get-id", async (req, res) => {
  const { user1Id, user2Id } = req.query;
  let result = await getChatId(user1Id, user2Id);
  // setting response depending upon the result received
  if (result.status === statusCodes.CHAT_FOUND)
    result = {
      chatId: result.chatId,
      status: 200
    };
  else if (result.status === statusCodes.CHAT_NOT_FOUND)
    result = {
      message: `Can't find chat between ${user1Id} and ${user2Id}`,
      status: 400
    };
  else if (result.status === statusCodes.SERVER_ERROR)
    result = {
      message: "Error fetching chat ID",
      status: 500
    };
  res.send(result);
});

router.get("/get-data", async (req, res) => {
  const { chatId, userId } = req.query;
  const result = await getChatData(chatId, userId);
  res.send(result);
});

module.exports = router;
