const { Router } = require("express");
const { login, createUser } = require("../controllers/userController");

const router = Router();

router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  const result = await login(email, password);
  res.send(result);
});

router.post("/create-user", async(req,res) => {
  const user = req.body;
  const result = await createUser(user);
  res.send(result);
});

module.exports = router;