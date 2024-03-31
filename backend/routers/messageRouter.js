const { Router } = require("express");
const checkMessageValidity = require( "../controllers/messageController/messageValidity" );
const router = Router();

router.post("/prompt", async(req,res) => {
  const message = req.body.message;
  const result = await checkMessageValidity(message);
  res.send(result);
});

module.exports = router;