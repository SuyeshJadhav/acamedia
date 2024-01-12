const { firestoreDB } = require("../firebaseConfig");

const getUser = async () => {
  const userRef = firestoreDB.collection("test").doc("doc1");
  userData =  (await userRef.get()).data();
  console.log(userData)
}

module.exports = getUser;