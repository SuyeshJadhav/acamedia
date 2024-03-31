const { firestoreDB } = require("../../utils/firebaseConfig");
const { usersCollectionName } = require("../../utils/variableNames");
const { getTimeStamp } = require("../../utils/generalHelperFunctions");
const {
  hashPassword,
  getUserIdByEmail,
  getUserIdByRollNo
} = require("./userHelperFunctions");

/*********************************************************
                    User Creation
*********************************************************/
const createUser = async user => {
  const { fname, lname, email, role, branch, degree, password } = user;

  // check if user already exists with same email
  const userExists = await getUserIdByEmail(email);
  if (userExists.status === 500)
    return {
      message: `Error checking for user`,
      status: 500,
      return: false
    };
  else if (userExists.status === 200)
    return {
      message: `User already exists with email ${email}`,
      status: 200,
      result: false
    };

  // check if student with given roll no exists
  if (role.toLowerCase() === "student") {
    const rollNoExists = await getUserIdByRollNo(user.rollno);

    if (rollNoExists.status === 500)
      return {
        message: `Error checking for student`,
        status: 500,
        return: false
      };
    else if (rollNoExists.status === 200)
      return {
        message: `Student already exists with roll no. ${user.rollno}`,
        status: 200,
        result: false
      };
  }

  // hash password
  const hashedPassword = await hashPassword(password);
  if (!hashedPassword.result) {
    return { message: `Unable to create new user`, status: 500, result: false };
  }

  // create a new user object to avoid extra data to be added
  const newUser = {
    fname,
    lname,
    email,
    role,
    branch,
    degree,
    password: hashedPassword,
    timeStamp: getTimeStamp()
  };
  if (role.toLowerCase() === "student") {
    newUser.year = user.year;
    newUser.rollno = user.rollno;
  }

  try {
    const userCollectionRef = firestoreDB.collection(usersCollectionName);
    const newUserDoc = await userCollectionRef.add(newUser);
    const newUserId = newUserDoc.id;
    return {
      userId: newUserId,
      message: "User created successfully",
      status: 200
    };
  } catch (error) {
    console.log(`Error creating new user :- ${error.message}`);
    return { message: `Unable to create new user`, status: 500 };
  }
};

module.exports = { createUser };
