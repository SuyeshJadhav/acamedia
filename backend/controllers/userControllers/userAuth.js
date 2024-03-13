const { firestoreDB } = require("../../firebaseConfig");
const { usersCollectionName } = require("../../variableNames");
const { getUserId } = require("../userHelperFunctions");
const bcrypt = require("bcryptjs");

//----------------------------- login --------------------------------
const login = async (email, password) => {
  const userId = await getUserId(email);
  // const userId = await checkUserInIndex(email);
  // check if user exists
  if (userId === false || userId === "NoUser") {
    return { message: `Unable to find user with email ${email}.`, status: `UserLoginFail` };
  }

  // get user data
  const userRef = firestoreDB.collection(usersCollectionName).doc(userId);
  let userDoc;
  try {
    userDoc = await userRef.get();
    if (!userDoc.exists) {
      return { message: `Unable to fetch user data.`, status: `UserLoginFail` };
    }
  } catch (error) {
    console.log(`Error fetching user data :- ${error.message}`);
    return { message: `Unable to fetch user data.`, status: `UserLoginFail` };
  }

  // check if password matches
  try {
    const savedPassword = userDoc.data().password;
    const passwordsMatch = await bcrypt.compare(password, savedPassword);
    if (!passwordsMatch) {
      return { message: "Wrong password.", status: "UserLoginFail" }
    }
  } catch (error) {
    console.log(`Error checking password :- ${error.message}`);
  }
  return { userId: userDoc.id, message: `User login successful`, status: "UserLoginSuccess" };
}


module.exports = {login}