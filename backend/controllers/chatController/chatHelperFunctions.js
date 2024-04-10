const admin = require("firebase-admin");
const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames, statusCodes } = require("../../utils/variableNames");

/*********************************************************
              Get Chat ID from 2 User's Data
*********************************************************/
const getChatId = async (user1Id, user2Id) => {
  const chatsCollectionRef = firestoreDB.collection(collectionNames.CHATS);
  const chatIdQuery1 = chatsCollectionRef.where("users", "==", [
    user1Id,
    user2Id
  ]);
  const chatIdQuery2 = chatsCollectionRef.where("users", "==", [
    user2Id,
    user1Id
  ]);

  try {
    let chatDocs = await chatIdQuery1.get();
    // if 1st query can't find chatId, check with 2nd query
    if (chatDocs.docs.length <= 0) chatDocs = await chatIdQuery2.get();
    if (chatDocs.docs.length <= 0)
      return { status: statusCodes.CHAT_NOT_FOUND };

    const chatId = chatDocs.docs[0].id;
    return { chatId, status: statusCodes.CHAT_FOUND };
  } catch (error) {
    console.log(`Error fetching chat ID :- \n${error}`);
    return { status: statusCodes.SERVER_ERROR };
  }
};

/*********************************************************
                      Delete Chat
*********************************************************/
const deleteChat = chatId => {
  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);

  try {
    chatRef.delete();
    return true;
  } catch (error) {
    console.log(`Error deleting chat ${chatId}:- \n${error}`);
    return false;
  }
};

/*********************************************************
                    Add Chat to User
*********************************************************/
const addChatToUser = async (chatId, userId) => {
  const userRef = firestoreDB.collection(collectionNames.USERS).doc(userId);
  try {
    await userRef.update({
      chats: admin.firestore.FieldValue.arrayUnion(chatId)
    });
  } catch (error) {
    deleteChat(chatId);
    console.error(
      `Error adding chatId ${chatId} to user ${userId} :- \n${error}`
    );
    return false;
  }
  return true;
};

/*********************************************************
          Check if Chat Exists in User's Chats List
*********************************************************/
const checkChatInUser = async (userId, chatId) => {
  try {
    // check if user exists
    const userRef = firestoreDB.collection(collectionNames.USERS).doc(userId);
    const userDoc = await userRef.get();
    if (!userDoc.exists)
      return { result: false, status: statusCodes.USER_NOT_FOUND };

    // check if chat exists in user
    const chats = userDoc.data().chats;
    if (!chats.includes(chatId))
      return { result: false, status: statusCodes.CHAT_NOT_IN_USER };

    return { result: true };
  } catch (error) {
    console.error(`Error checking chat in user data:- \n${error}`);
    return { result: false, status: statusCodes.SERVER_ERROR };
  }
};

module.exports = { getChatId, deleteChat, addChatToUser, checkChatInUser };
