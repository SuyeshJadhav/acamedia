const admin = require("firebase-admin");
const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames } = require("../../utils/variableNames");


/*********************************************************
              Get Chat ID from 2 User's Data
*********************************************************/
const getChatId = async (user1Id, user2Id) => {
  const chatCollectionRef = firestoreDB.collection(collectionNames.CHATS);
  const chatIdQuery1 = chatCollectionRef.where("users", "==", [
    user1Id,
    user2Id
  ]);
  const chatIdQuery2 = chatCollectionRef.where("users", "==", [
    user2Id,
    user1Id
  ]);

  try {
    let chatDocs = await chatIdQuery1.get();
    console.log(chatDocs.docs);
    // if 1st query can't find chatId, check with 2nd query
    if (chatDocs.docs.length <= 0) chatDocs = await chatIdQuery2.get();
    if (chatDocs.docs.length <= 0){
      console.log("Couldn't find chatId.");
      return false;
    }
    const chatId = chatDocs.docs[0].id;
    return chatId;
  } catch (error) {
    console.log(`Error fetching chat ID :- \n${error}`);
    return false;
  }
};

/*********************************************************
                      Delete Chat
*********************************************************/
const deleteChat = (chatId) => {
  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);

  try{
    chatRef.delete();
    return true;
  } catch(error) {
    console.log(`Error deleting chat ${chatId}:- \n${error}`);
    return false;
  }
}

/*********************************************************
                    Add Chat to User
*********************************************************/
const addChatToUser = async (chatId, userId) => {
  const userRef = firestoreDB.collection(collectionNames.USERS).doc(userId);
  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);
  try {
    await userRef.update({
      chats: admin.firestore.FieldValue.arrayUnion(chatRef)
    });
  } catch (error) {
    deleteChat(chatId);
    console.error(`Error adding chatId ${chatId} to user ${userId} :- \n${error}`);
    return false;
  }
  return true;
};

module.exports = { getChatId , deleteChat, addChatToUser};
