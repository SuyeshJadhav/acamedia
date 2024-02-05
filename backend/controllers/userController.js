const bcrypt = require("bcryptjs");
const admin = require("firebase-admin");
const { firestoreDB } = require("../firebaseConfig");
const { usersCollectionName, usersIndexDocName } = require("../variableNames");
const { getTimeStamp } = require("../helperFunctions");

//---------------------- user creation ---------------------------
const createUser = async (user) => {
  const { fname, lname, email, role, branch, degree, password } = user;

  // check if user already exists with same email
  const userExists = await checkUserInIndex(email);
  if (!userExists) {
    return { message: `Error checking for user.`, status: "UserCreationFail" };
  }
  else if (userExists !== "NoUser") {
    return { message: `User already exists with email ${email}.`, status: "UserCreationFail" };
  }

  // hash password
  const hashedPassword = await hashPassword(password);
  if (!hashedPassword) {
    return { message: `Unable to create new user`, status: `UserCreationFail` };
  }

  // create a new user object to avoid extra data to be added
  const newUser = {
    fname, lname, email, role, branch, degree,
    password: hashedPassword,
    timeStamp: getTimeStamp()
  }
  if (role.toLowerCase() === "student") {
    newUser.year = user.year;
    newUser.rollno = user.rollno;
  }

  try {
    const userCollectionRef = firestoreDB.collection(usersCollectionName);
    const newUserDoc = await userCollectionRef.add(newUser);
    const newUserId = newUserDoc.id;
    const userAdded = await addToUserIndex(email, newUserId);
    if (!userAdded) {
      console.log("Unable to add user to users index");
      return { message: `Unable to create new user`, status: `UserCreationFail` };
    }
    return { userId: newUserId, message: "User created successfully.", status: "UserCreationSuccess" };
  } catch (error) {
    console.log(`Error creating new user :- ${error.message}`);
    return { message: `Unable to create new user`, status: `UserCreationFail` };
  }
}

//----------------------------- login --------------------------------
const login = async (email, password) => {
  const userId = await checkUserInIndex(email);
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

module.exports = { createUser, login };