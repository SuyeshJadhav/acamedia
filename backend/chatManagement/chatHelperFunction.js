const { firestoreDB } = require("../firebaseConfig");
const { chatsCollectionName } = require("../variableNames");

// ------------------- GET CHAT ID FROM 2 USER'S ID ---------------------
const getChatId = async (user1Id, user2Id) => {
  const chatCollectionRef = firestoreDB.collection(chatsCollectionName);
  const chatIdQuery = chatCollectionRef
    .where("users", "array-contains", user1Id, user2Id)

  try {
    const chatDocs = await chatIdQuery.get();
    if (chatDocs.docs.length === 1) {
      const chatId = chatDocs.docs[0].id;
      return chatId;
    } else return false;
  } catch (error) {
    console.log(`Error fetching chat ID :- ${error.message}`);
    return false;
  }
};

module.exports = { getChatId };
