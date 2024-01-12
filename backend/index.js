const express = require("express");
const cors = require("cors");
require("dotenv").config()

const UserRouter = require("./routers/userRouter");

const app = express();
app.use(cors({
	origin: "*"
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/user", UserRouter);

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log(`Server is connected to port ${PORT}`));
