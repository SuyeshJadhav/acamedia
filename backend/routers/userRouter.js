const { Router } = require("express");

const getUser = require("../controllers/getUser");
const {
  loginUser,
  verifyEmailandSendOTP,
  verifyOTP,
  setPassword,
} = require("../controllers/userController");

const router = Router();

// router.get("/login", async (req, res) => {
//   await loginUser();
// });

router.post("/login", loginUser);
router.post("/verifyEmail", verifyEmailandSendOTP);
router.post("/verifyOTP", verifyOTP);
router.post("/setPassword", setPassword);

module.exports = router;
