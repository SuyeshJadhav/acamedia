const { firestoreDB } = require("../firebaseConfig");

const loginUser = async (req, res, next) => {
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

module.exports = loginUser;
