const bcrypt = require("bcryptjs");
const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames, statusCodes } = require("../../utils/variableNames");

/*********************************************************
                    Hash Password
*********************************************************/
const hashPassword = async password => {
  try {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    return hashedPassword;
  } catch (error) {
    console.log(`Error hashing password :- \n${error}`);
    return false;
  }
};

/*********************************************************
                  Get User ID by Email
*********************************************************/
const getUserIdByEmail = async email => {
  const usersCollectionRef = firestoreDB.collection(collectionNames.USERS);
  const query = usersCollectionRef.where("email", "==", email.toLowerCase());
  try {
    const userDocList = await query.get();
    if (userDocList.docs.length <= 0) return { result: false, status: statusCodes.USER_NOT_FOUND };

    return { result: userDocList.docs[0].id, status: statusCodes.USER_FOUND };
  } catch (error) {
    console.log(`Error checking user using email:- \n${error}`);
    return { result: false, status: statusCodes.SERVER_ERROR };
  }
};

/*********************************************************
        Check if Student with Given Roll No Exists
*********************************************************/
const getUserIdByRollNo = async rollno => {
  const usersCollectionRef = firestoreDB.collection(collectionNames.USERS);
  const query = usersCollectionRef.where("rollno", "==", rollno);
  try {
    const userDocList = await query.get();
    if (userDocList.docs.length <= 0) return { result: false, status: statusCodes.USER_NOT_FOUND };

    console.log("");
    return { result: userDocList.docs[0].id, status: statusCodes.USER_FOUND };
  } catch (error) {
    console.log(`Error checking student using rollno:- \n${error}`);
    return { status: statusCodes.SERVER_ERROR };
  }
};

module.exports = { hashPassword, getUserIdByEmail, getUserIdByRollNo };
