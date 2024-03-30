const { firestoreDB } = require("../firebaseConfig"),
  { chatsCollectionName, usersCollectionName } = require("../variableNames"),
  admin = require("firebase-admin");

const createChat = async (user1Id, user2Id) => {
  //make sure that user1 and user2 actually exist
  try {
    const user1Exists = await checkUser(user1Id);
    const user2Exists = await checkUser(user2Id);
    if (!user1Exists) {
      return {
        message: `User with ID ${user1Id} doesn't exist.`,
        status: "UserAbsence",
      };
    }
    if (!user2Exists) {
      return {
        message: `User with ID ${user2Id} doesn't exist.`,
        status: "UserAbsence",
      };
    }
  } catch (error) {
    console.error(`Error checking users :- ${error.message}`);
    return {
      message: `Unable to check user existence.`,
      status: "UserCheckError",
    };
  }

  let chatId = "";
  //create new chat and add the user1 and user2 as members
  try {
    const chatCollectionRef = firestoreDB.collection(chatsCollectionName);
    const chatDoc = await chatCollectionRef.add({
      users: { user1Id, user2Id },
      messages: [],
    });
    chatId = chatDoc.id;
  } catch (error) {
    console.error(`Error creating new chat :- ${error.message}`);
    return {
      message: `Unable to create new chat for ${user1Id} and ${user2Id}.`,
      status: "ChatCreationError",
    };
  }

  //add chat to user1 and user2 chats array
  const chatAddedToUser1 = await addChatToUser(chatId, user1Id);
  if (!chatAddedToUser1) {
    return {
      message: `Unable to add chat ${chatId} to user ${user1Id}.`,
      status: "ChatAdditionError",
    };
  }
  const chatAddedToUser2 = await addChatToUser(chatId, user2Id);
  if (!chatAddedToUser2) {
    return {
      message: `Unable to add chat ${chatId} to user ${user1Id}.`,
      status: "ChatAdditionError",
    };
  }

  return {
    chatId,
    message: `Added chat ${chatId} to users ${user1Id} and ${user2Id}.`,
    status: "ChatCreationSuccess",
  };
};

//checks if user exists in the "users" collection
const checkUser = async (userId) => {
  const userRef = firestoreDB.collection(usersCollectionName).doc(userId);
  const userDoc = await userRef.get();
  if (userDoc.exists) return true;
  else return false;
};

//adds new chat to user's chats array
const addChatToUser = async (chatId, userId) => {
  const userRef = firestoreDB.collection(usersCollectionName).doc(userId);
  try {
    await userRef.update({
      chats: admin.firestore.FieldValue.arrayUnion(chatId),
    });
  } catch (error) {
    console.error(`Error adding chatId to user ${userId} :- ${error.message}`);
    return false;
  }
  return true;
};

module.exports = createChat;
