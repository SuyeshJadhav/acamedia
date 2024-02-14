const { Router } = require("express");
const router = Router();
const path = require("path");
router.get("/", (req, res) => {
  const indexPath = path.join(__dirname, "..", "views", "index.html");
  res.sendFile(indexPath);
});

module.exports = router;
