const { firestoreDB } = require("../../utils/firebaseConfig");
const { collectionNames, statusCodes } = require("../../utils/variableNames");
const { getTimeStamp } = require("../../utils/generalHelperFunctions");
const { checkChatInUser } = require("../chatController/chatHelperFunctions");
const checkMessageValidity = require( "./messageValidity" );

/*********************************************************
                    Store Message
*********************************************************/
const storeMessage = async (senderId, senderRole, receiverRole, chatId, message) => {
  // check if user and chat are related
  const chatInUser = await checkChatInUser(senderId, chatId);
  if (chatInUser.statusCode === statusCodes.SERVER_ERROR)
    return {
      message: "Error sending message",
      status: 500
    };
  else if (chatInUser.status === statusCodes.CHAT_NOT_IN_USER)
    return {
      message: `User ${senderId} doesn't relate with chat ${chatId}.`,
      status: 400
    };

  if(!(senderRole === "student" && receiverRole === "student")){
    const result = await checkMessageValidity(message.text, senderRole);
    if(result.status === statusCodes.INAPPROPRIATE_MESSAGE) return {message: result.message, status: 403 };
  }

  // add new message to message collection, and create if it doesn't exist
  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);
  const messageCollectionRef = chatRef.collection(collectionNames.MESSAGES);

  // store message in database with timestamp
  try {
    const timeStamp = getTimeStamp();
    const messageDoc = await messageCollectionRef.add({
      sender: senderId,
      message: message,
      timeStamp
    });
    const messageId = messageDoc.id;

    return { messageId, timeStamp, status: 200 };
  } catch (error) {
    console.error(`Error storing message:- \n${error}`);
    return { message: `Error sending message`, status: 500 };
  }
};

/*********************************************************
                    Delete Message
*********************************************************/
const deleteMessage = async (userId, chatId, messageId) => {
  // check if user and chat are related
  const chatInUser = checkChatInUser(userId, chatId);
  if (chatInUser.statusCode === statusCodes.SERVER_ERROR)
    return {
      message: "Error deleting message",
      status: 500
    };
  else if (chatInUser.status === statusCodes.CHAT_NOT_IN_USER)
    return {
      message: `User ${senderId} doesn't relate with chat ${chatId}.`,
      status: 400
    };

  const chatRef = firestoreDB.collection(collectionNames.CHATS).doc(chatId);
  const messageRef = chatRef
    .collection(collectionNames.MESSAGES)
    .doc(messageId);

  try {
    await messageRef.delete();
    return { message: `Message ${messageId} deleted successfully.`, status: 200 };
  } catch (error) {
    console.log(`Error deleting message ${messageId} :- \n${error}`);
    return {
      message: `Error deleting message`,
      status: 500
    };
  }
};

module.exports = { storeMessage, deleteMessage };
