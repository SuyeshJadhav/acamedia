const { firestoreDB } = require("../../utils/firebaseConfig");
const { chatsCollectionName } = require("../../utils/variableNames");


/*********************************************************
              Get Chat ID from 2 User's Data
*********************************************************/
const getChatId = async (user1Id, user2Id) => {
  const chatCollectionRef = firestoreDB.collection(chatsCollectionName);
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
    if (chatDocs.docs.length <= 0) chatDocs = await chatIdQuery2.get();
    if (chatDocs.docs.length <= 0){
      console.log("Couldn't find chatId.");
      return false;
    }
    const chatId = chatDocs.docs[0].id;
    return chatId;
  } catch (error) {
    console.log(`Error fetching chat ID :- ${error.message}`);
    return false;
  }
};

module.exports = { getChatId };
