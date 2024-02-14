const { Router } = require("express");
const { login, createUser } = require("../controllers/userController");

const router = Router();

// router.get("/login", async (req, res) => {
//   await loginUser();
// });

// router.post("/login", login);
// router.post("/verifyEmail", verifyEmailandSendOTP);
// router.post("/verifyOTP", verifyOTP);
// router.post("/setPassword", setPassword);

// router.post("/chat", async (req, res) => {
//   const { user1Id, user2Id } = req.body;
//   const result = await createChat(user1Id, user2Id);
// });
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  const result = await login(email, password);
  res.send(result);
});

router.post("/create-user", async (req, res) => {
  const user = req.body;
  const result = await createUser(user);
  res.send(result);
});

module.exports = router;
