const {Router} = require("express")

const getUser = require("../controllers/getUser");

const router = Router();

router.get("/login", async (req, res) => {
  await getUser()
});

module.exports = router;