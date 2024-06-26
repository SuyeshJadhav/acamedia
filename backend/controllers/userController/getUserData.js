const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames, statusCodes } = require("../../utils/variableNames");

/*********************************************************
                    Get User Data
*********************************************************/
const getUserData = async userId => {
  const user = await getUserDataById(userId);
  // check if user exists
  if (user.status === statusCodes.SERVER_ERROR)
    return {
      message: `Error getting user data`,
      status: 500
    };
  else if (user.status === statusCodes.USER_NOT_FOUND)
    return {
      message: `Couldn't find user with given ID`,
      status: 404
    };
  const userData = user.userData;

  // delete data that is not required
  delete userData.password;
  delete userData.timeStamp;

  return { ...userData, status: 200 };
};

/*********************************************************
                  Get User Data by Id
*********************************************************/
const getUserDataById = async userId => {
  const userRef = firestoreDB.collection(collectionNames.USERS).doc(userId);

  try {
    const userDoc = await userRef.get();
    if (!userDoc.exists)
      return { result: false, status: statusCodes.USER_NOT_FOUND };
    return { userData: userDoc.data(), status: statusCodes.USER_FOUND };
  } catch (error) {
    console.log(`Error fetching user data :- \n${error}`);
    return { status: statusCodes.SERVER_ERROR };
  }
};

module.exports = { getUserData, getUserDataById };
