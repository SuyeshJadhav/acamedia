const { firestoreDB } = require("../firebaseConfig");
const nodemailer = require("nodemailer");

const generateOTP = () => {
  var genOTP = Math.floor(
    Math.pow(10, 5 - 1) +
      Math.random() * (Math.pow(10, 5) - Math.pow(10, 5 - 1) - 1)
  );
  return genOTP;
};

const verifyEmailandSendOTP = async (req, res) => {
  try {
    const { email } = req.body;

    const userRef = firestoreDB.collection("users");
    const query = userRef.where("email", "==", email);
    const result = await query.get();

    if (result.empty) {
      throw new Error("User not found");
    }

    const transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true,
      auth: {
        user: process.env.NODEMAILER_USERNAME,
        pass: process.env.NODEMAILER_PASSWORD,
      },
      // tls: {
      //   rejectUnauthorized: false,
      // },
    });

    const otp = generateOTP();

    const msg = {
      from: `"Acamedia Team" <${process.env.NODEMAILER_USERNAME}>`,
      to: [
        "dedhia.dr@somaiya.edu",
        "aditya.chandran@somaiya.edu",
        "suyesh.j@somaiya.edu",
        "vedant.hc@somaiya.edu",
      ],
      subject: "Sending Email using Node.js/Node Mailer",
      text: `OTP is ${otp}`,
    };

    transporter.sendMail(msg, (error, info) => {
      if (error) {
        console.log(error);
      } else {
        console.log("Email sent: " + info.response);
      }
    });

    return res.status(201).json({ message: "OTP Sent Successfully" });
  } catch (error) {
    console.log(error);
  }
};

const verifyOTP = async (req, res) => {
  try {
    const { otp } = req.body;
    console.log("OTP", otp);
    console.log("OTP GEN", genOTP);

    return res.status(201).json({ message: "OTP Verified" });
  } catch (error) {}
};

const setPassword = async (req, res) => {
  try {
  } catch (error) {}
};

const loginUser = async (req, res) => {
  try {
    const { email, pass } = req.body;

    const userRef = firestoreDB.collection("users");
    const query = userRef.where("email", "==", email);
    const result = await query.get();

    if (result.empty) {
      throw new Error("User not found");
    }

    result.forEach((doc) => {
      const { password } = doc.data();
      if (password != pass) {
        throw new Error("Incorrect Password");
      } else {
        return res.status(201).json(doc.data());
      }
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = { loginUser, verifyEmailandSendOTP, verifyOTP, setPassword };
