const { Router } = require("express");

const getUser = require("../controllers/getUser");
const loginUser = require("../controllers/userController");

const router = Router();

router.get("/login", async (req, res) => {
  await loginUser();
});

module.exports = router;
