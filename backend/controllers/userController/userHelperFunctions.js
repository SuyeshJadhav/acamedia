const bcrypt = require("bcryptjs");
const { firestoreDB } = require("../../utils/firebaseConfig");
const { usersCollectionName } = require("../../utils/variableNames");

/*********************************************************
                    Hash Password
*********************************************************/
const hashPassword = async password => {
  try {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    return { result: hashedPassword, status: 200 };
  } catch (error) {
    console.log(`Error hashing password :- \n${error}`);
    return { result: false, status: 500 };
  }
};

/*********************************************************
                  Get User ID by Email
*********************************************************/
const getUserIdByEmail = async email => {
  const usersCollectionRef = firestoreDB.collection(usersCollectionName);
  const query = usersCollectionRef.where("email", "==", email.toLowerCase());
  try {
    const userDocList = await query.get();
    if (userDocList.docs.length <= 0) return { result: false, status: 404 };

    return { result: userDocList.docs[0].id, status: 200 };
  } catch (error) {
    console.log(`Error checking user using email:- \n${error}`);
    return { result: false, status: 500 };
  }
};

/*********************************************************
        Check if Student with Given Roll No Exists
*********************************************************/
const getUserIdByRollNo = async rollno => {
  const usersCollectionRef = firestoreDB.collection(usersCollectionName);
  const query = usersCollectionRef.where("rollno", "==", rollno);
  try {
    const userDocList = await query.get();
    if (userDocList.docs.length <= 0) return { result: false, status: 404 };

    console.log("");
    return { result: userDocList.docs[0].id, status: 200 };
  } catch (error) {
    console.log(`Error checking student using rollno:- \n${error}`);
    return { result: false, status: 500 };
  }
};

module.exports = { hashPassword, getUserIdByEmail, getUserIdByRollNo };
