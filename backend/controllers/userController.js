const { compare, hash } = require("bcryptjs");

const { firestoreDB } = require("../firebaseConfig");
const mailSender = require("../utils/mailSender");

var genOTP;

const generateOTP = () => {
  return Math.floor(
    Math.pow(10, 5 - 1) +
      Math.random() * (Math.pow(10, 5) - Math.pow(10, 5 - 1) - 1)
  );
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

    genOTP = generateOTP();

    try {
      console.log("Gen OTP: ", genOTP);
      mailSender(genOTP);
    } catch (error) {
      console.log(error);
    }

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

    if (genOTP != otp) {
      return res.status(400).json({ message: "Invalid OTP" });
    }
    return res.status(201).json({ message: "OTP Verified" });
  } catch (error) {}
};

const setPassword = async (req, res) => {
  try {
    const { email, password } = req.body;

    const userRef = firestoreDB.collection("users");
    const query = userRef.where("email", "==", email);
    const result = await query.get();

    if (result.empty) {
      return res.status(404).json({ message: "User not found" });
    }

    const hashedPass = await hash(password, 10);
    result.forEach(async (doc) => {
      await doc.ref.set({ password: hashedPass }, { merge: true });
    });

    return res.status(201).json({ message: "Password set" });
  } catch (error) {
    console.log(error);
  }
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

    result.forEach(async (doc) => {
      const { password } = doc.data();
      const passMatch = await compare(pass, password);
      if (passMatch) {
        return res.status(201).json(doc.data());
      } else {
        return res.status(400).json({ message: "Incorrect Password" });
      }
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = { loginUser, verifyEmailandSendOTP, verifyOTP, setPassword };
