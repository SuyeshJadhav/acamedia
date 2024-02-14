const { Router } = require("express");

const getUser = require("../controllers/getUser");
const {
  loginUser,
  verifyEmailandSendOTP,
  verifyOTP,
  setPassword,
} = require("../controllers/userController");
const createChat = require("../chatManagement/createChat");

const router = Router();

// router.get("/login", async (req, res) => {
//   await loginUser();
// });

router.post("/login", loginUser);
router.post("/verifyEmail", verifyEmailandSendOTP);
router.post("/verifyOTP", verifyOTP);
router.post("/setPassword", setPassword);

router.post("/chat", async (req, res) => {
  const { user1Id, user2Id } = req.body;
  const result = await createChat(user1Id, user2Id);
  res.send(result);
});

module.exports = router;
