const { Router } = require("express");
const { createUser } = require("../controllers/userController/createUser");
const { login } = require("../controllers/userController/auth");
const { getUserData } = require("../controllers/userController/getUserData");

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

router.post("/register", async (req, res) => {
  const user = req.body;
  const result = await createUser(user);
  res.send(result);
});

router.get("/get-data", async(req,res) => {
  const {email, userId} = req.body;
  const result = await getUserData(email, userId);
  res.send(result);
})

module.exports = router;
