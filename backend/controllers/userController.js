const { firestoreDB } = require("../firebaseConfig");

const loginUser = async () => {
  const value = "dhruv@somaiya.edu";
  const userRef = firestoreDB.collection("users");
  const query = userRef.where("email", "==", value);

  try {
    const querySnapshot = await query.get();
    
    querySnapshot.forEach((doc) => {
      console.log(doc.data());
    });

    return "banana";
  } catch (error) {
    console.error("Error getting documents:", error);
  }
};

module.exports = loginUser;
