const bcrypt = require("bcryptjs");
const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames, statusCodes } = require("../../utils/variableNames");
const { getUserIdByEmail } = require("./userHelperFunctions");
const { getUserDataById } = require( "./getUserData" );

/*********************************************************
                     Login User
*********************************************************/
const login = async (email, password) => {
  const userId = await getUserIdByEmail(email);
  if (userId.status === statusCodes.SERVER_ERROR)
    return {
      message: `Error authorizing user`,
      status: 500
    };
  else if (userId.status === statusCodes.USER_NOT_FOUND)
    return {
      message: `User with ${email} doesn't exist`,
      status: 404
    };

  // get user data
  const userData = getUserDataById(user);
  if (userId.status === statusCodes.SERVER_ERROR)
    return {
      message: `Error authorizing user`,
      status: 500
    };
  else if (userId.status === statusCodes.USER_NOT_FOUND)
    return {
      message: `Unable to fetch user data`,
      status: 404
    };

  // check if password matches
  try {
    const savedPassword = userData.password;
    const passwordsMatch = await bcrypt.compare(password, savedPassword);
    if (!passwordsMatch) {
      return { message: "Wrong password.", status: 403 };
    }
  } catch (error) {
    console.log(`Error checking password :- ${error.message}`);
  }
  return {
    userId: userDoc.id,
    message: `User login successful`,
    status: 200
  };
};

module.exports = { login };
