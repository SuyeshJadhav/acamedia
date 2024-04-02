const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames } = require("../../utils/variableNames");

const getChatData = async (chatId, userId) => {
  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);
  const messageCollectionRef = chatRef.collection(collectionNames.MESSAGES);

  try {
		// check if chat exists
    const chatDoc = await chatRef.get();
    if (!chatDoc.exists)
      return { message: `Unable to find chat with ID ${chatId}`, status: 404 };

		// check if given user is related to the chat
		const users = chatDoc.data().users;
    if (!users.includes(userId))
      return { message: `Unable to find user ${userId} in chat ${chatId}` };
		// fetch the other user in the users array
    const otherUser = users[0] === userId ? users[1] : users[0];

		// list all messages of the chat
    const messageDocs = await messageCollectionRef.orderBy("timeStamp").get();

    let messageList = [];
    messageDocs.forEach(message => messageList.push(message.data()));

    return { otherUser, messageList, status: 200 };
  } catch (error) {
    console.error(`Error fetching chat data:- \n${error}`);
    return { message: "Error fetching chat data", status: 500 };
  }
};

module.exports = getChatData;
