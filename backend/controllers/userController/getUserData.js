const { firestoreDB } = require("../../utils/firebaseConfig");
const { usersCollectionName } = require("../../utils/variableNames");

/*********************************************************
                    Get User Data
*********************************************************/
const getUserData = async (email, userId) => {
  // strictly only one of email or user id
  if (email && userId)
    return {
      message: "Unauthorized access to fetch data",
      status: 403
    };
  else if (!email && !userId)
    return { message: "Insufficient parameters", status: 400 };

  const result = email
    ? await getUserDataByEmail(email)
    : await getUserDataById(userId);

  // check if user exists
  if (result.status === 500)
    return {
      message: `Error getting user data`,
      status: 500
    };
  else if (result.status === 404)
    return {
      message: `Couldn't find user with given ${email ? "email" : "ID"}`,
      status: 404
    };
    
  const userData = result.userData;

  // delete data that is not required
  if (email) {
    delete userData.email;
    delete userData.chats;
  }
  delete userData.password;
  delete userData.timeStamp;

  return { ...userData, status: 200 };
};

/*********************************************************
                  Get User Data by Email
*********************************************************/
const getUserDataByEmail = async email => {
  const userCollectionRef = firestoreDB.collection(usersCollectionName);
  const query = userCollectionRef.where("email", "==", email);

  try {
    const userDocList = await query.get();
    if (userDocList.docs.length <= 0) return { result: false, status: 404 };
    return { userData: userDocList.docs[0].data(), status: 200 };
  } catch (error) {
    console.log(`Error fetching user data:- \n${error}`);
    return { status: 500 };
  }
};

/*********************************************************
                  Get User Data by Id
*********************************************************/
const getUserDataById = async userId => {
  const userRef = firestoreDB.collection(usersCollectionName).doc(userId);

  try {
    const userDoc = await userRef.get();
    if (!userDoc.exists) return { result: false, status: 404 };
    return { userData: userDoc.data(), status: 200 };
  } catch (error) {
    console.log(`Error fetching user data :- \n${error}`);
    return { status: 500 };
  }
};

module.exports = { getUserData, getUserDataById };
