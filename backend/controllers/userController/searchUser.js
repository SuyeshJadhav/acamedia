const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames } = require("../../utils/variableNames");

const searchUser = async (searchText, filterRole, filterBranch) => {
  const text = searchText.toLowerCase();
  const role =
    filterRole.toLowerCase() === "none" ? "" : filterRole.toLowerCase();
  const branch =
    filterBranch.toLowerCase() === "none" ? "" : filterBranch.toLowerCase();

  const usersCollectionRef = firestoreDB.collection(collectionNames.USERS);
  const fields = ["fname", "mname", "lname", "email"];

  // Use a Map instead of a Set for efficient retrieval using userId as key
  const userMap = new Map();
  try {
    for (const i in fields) {
      const userQuery = usersCollectionRef
        .where(fields[i], ">=", text)
        .where(fields[i], "<=", text + "\uf8ff")
        .where("role", ">=", role)
        .where("role", "<=", role + "\uf8ff")
        .where("branch", ">=", branch)
        .where("branch", "<=", branch + "\uf8ff")

      const userDocs = await userQuery.get();

      for (const userDoc of userDocs.docs) {
        const user = userDoc.data();
        user.userId = userDoc.id;
        delete user.password;
        delete user.chats;
        delete user.timeStamp;

        // Check for existing user with same userId before adding
        if (!userMap.has(user.userId)) {
          userMap.set(user.userId, user);
        }
      }
    }

    // Get an array of unique users from the Map
    const uniqueUserList = Array.from(userMap.values());

    return { result: uniqueUserList, status: 200 };
  } catch (error) {
    console.error(`Error fetching search result:- \n${error}`);
    return { message: "Error fetching search results.", status: 500 };
  }
};

module.exports = searchUser;
