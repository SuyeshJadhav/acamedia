const { firestoreDB } = require("../../firebaseConfig")
const { usersCollectionName } = require("../../variableNames")

const getUserData = async (email, userId) => {
  // strictly only one of email or user id
  if(email && userId) return { message: "Unauthorized access to fetch data", status: "UserSearchFail" };
  else if (!email && !userId) return { message: "Insufficient parameters", status: "UserSearchFail" };

  const userData = email ? await getDataByEmail(email) : await getDataById(userId);
  if(!userData) {
    return { message: `Couldn't find user with given ${email ? "email" : "ID"}`, status: "UserSearchFail" };
  }

  // delete data that is not required
  if(email){
    delete userData.email;
    delete userData.chats;
  }
  delete userData.password;
  delete userData.timeStamp;

  return { ...userData, status: "UserSearchSuccess" }
}

//--------------------------- GET DATA BY EMAIL ------------------------
const getDataByEmail = async (email) => {
  const userCollectionRef = firestoreDB.collection(usersCollectionName);
  const query = userCollectionRef.where("email", "==", email);

  try{
    userDocs = await query.get();
    if (userDocs.empty) return false;
    // snapshot by query gives an array
    userData = userDocs.docs[0].data();
    return userData;
  } catch (error) {
    console.log(`Error fetching user data :- ${error.message}`);
    return false;
  }
}

//------------------------- GET DATA BY USER ID ------------------------
const getDataById = async (userId) => {
  const userRef = firestoreDB.collection(usersCollectionName).doc(userId);
  
  try{
    const userDoc = await userRef.get();
    if (!userDoc.exists) return false;
    userData = userDoc.data();
    return userData;
  } catch (error) {
    console.log(`Error fetching user data :- ${error.message}`);
    return false;
  }
}

module.exports = { getUserData }