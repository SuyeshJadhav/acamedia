const bcrypt = require("bcryptjs");
const { firestoreDB } = require("../firebaseConfig");
const { usersCollectionName } = require("../variableNames");

//------------------------- hash password ------------------------
const hashPassword = async (password) => {
  try {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    return hashedPassword;
  } catch (error) {
    console.log(`Error hashing password :- ${error.message}`);
    return false;
  }
}

//--------------------- get user if using email ---------------------
const getUserId = async (email) => {
  const usersCollectionRef = firestoreDB.collection(usersCollectionName);
  const query = usersCollectionRef.where("email", "==", email.toLowerCase());
  const userDocList = await query.get();
  return userDocList[0].id;
}

//------------------- add user to usersIndex ----------------------
const addToUserIndex = async (email, userId) => {
  const usersIndexRef = firestoreDB.collection(usersCollectionName).doc(usersIndexDocName);
  // create users index if it doesn't exist
  const usersIndexCreated = createUsersIndex();
  if (!usersIndexCreated) return false;

  // add new user to users index
  try {
    // replace . with - since . is seen as field separator
    const modifiedEmail = email.replace(/\./g, '-');
    await usersIndexRef.update({
      [modifiedEmail]: userId
    });
    console.log("User added to users index");
    return true;
  } catch (error) {
    console.log(`Error adding user to users index :- ${error.message}`);
    return false;
  }
}

//----------------------- check user existence -----------------------
const checkUserInIndex = async (email) => {
  const usersIndexRef = firestoreDB.collection(usersCollectionName).doc(usersIndexDocName);
  try {
    const usersIndex = await usersIndexRef.get();
    if (!usersIndex.exists) {
      const usersIndexCreated = createUsersIndex();
      if (!usersIndexCreated) return false;
      return "NoUser";
    }
    const usersIndexData = usersIndex.data();

    const modifiedEmail = email.replace(/\./g, '-');
    if (usersIndexData.hasOwnProperty([modifiedEmail])) {
      return usersIndexData[modifiedEmail];
    }
    else return "NoUser";
  } catch (error) {
    console.log(`Error adding user to users index :- ${error.message}`);
    return false;
  }
}

//------------- create users index ------------------------
const createUsersIndex = async () => {
  const usersIndexRef = firestoreDB.collection(usersCollectionName).doc(usersIndexDocName);
  try {
    const usersIndex = await usersIndexRef.get()
    if (!usersIndex.exists) {
      await usersIndexRef.set({});
      console.log(`Created users index`);
      return true;
    }
  } catch (error) {
    console.log(`Error creating users index :- ${error.message}`);
    return false;
  }
}

module.exports = {hashPassword, getUserId, addToUserIndex, createUsersIndex, checkUserInIndex};