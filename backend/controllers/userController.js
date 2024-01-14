const { firestoreDB } = require("../firebaseConfig");
const { query, where, getDoc, collection } = require("firebase/firestore");

const loginUser = async () => {
  const value = "dhruv@somaiya.edu";
  const userRef = firestoreDB.collection("users");
  const q = query(userRef, where("email", "==", value));

  q.get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        const data = doc.data();
        console.log(data);
      });
    })
    .catch((error) => {
      console.error("Error getting documents:", error);
    });
};

module.exports = loginUser;
