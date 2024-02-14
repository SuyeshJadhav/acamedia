const bcrypt = require("bcryptjs");
const admin = require("firebase-admin");
const { firestoreDB } = require("../../firebaseConfig");
const { usersCollectionName, usersIndexDocName } = require("../../variableNames");
const { getTimeStamp } = require("../../helperFunctions");
const { getUserId, hashPassword, checkUserInIndex } = require("../userHelperFunctions");

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
    // const userAdded = await addToUserIndex(email, newUserId);
    // if (!userAdded) {
    //   console.log("Unable to add user to users index");
    //   return { message: `Unable to create new user`, status: `UserCreationFail` };
    // }
    return { userId: newUserId, message: "User created successfully.", status: "UserCreationSuccess" };
  } catch (error) {
    console.log(`Error creating new user :- ${error.message}`);
    return { message: `Unable to create new user`, status: `UserCreationFail` };
  }
}


module.exports = { createUser};