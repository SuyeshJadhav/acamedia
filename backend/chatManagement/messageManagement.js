const admin = require("firebase-admin");
const { firestoreDB } = require("../firebaseConfig");
const { chatsCollectionName, messagesCollectionName, usersCollectionName } = require("../variableNames");
const { getTimeStamp } = require("../helperFunctions");

//---------------------- store message --------------------------------
const storeMessage = async (senderId, chatId, message) => {
  const correctUser = checkUser(senderId, chatId);
  if (!correctUser) {
    return { message: `User ${senderId} doesn't relate with chat ${chatId}.`, status: "MessageSendingFail" };
  }

  const chatRef = firestoreDB.collection(chatsCollectionName).doc(chatId);
  const messageCollectionRef = chatRef.collection(messagesCollectionName);

  // store message in database with timestamp
  try {
    const timeStamp = getTimeStamp();
    console.log(timeStamp);
    const messageDoc = await messageCollectionRef.add({
      sender: senderId,
      message,
      timeStamp
    });
    const messageId = messageDoc.id;

    return { messageId, timeStamp, status: "MessageSendingSuccess" };
  } catch (error) {
    console.error(`Error storing message :- ${error.message}`);
    return { message: `Unable to send message.`, status: "MessageSendingFail" };
  }
}


//--------------- delete message given chatId --------------------------
const deleteMessage = async (userId, chatId, messageId) => {
  const correctUser = checkUser(userId, chatId);
  if (!correctUser) {
    return { message: `User doesn't relate with chat.`, status: "MessageSendingFail" };
  }

  const chatRef = firestoreDB.collection(chatsCollectionName).doc(chatId);
  const messageRef = chatRef.collection(messagesCollectionName).doc(messageId);

  try {
    await messageRef.delete();
    console.log(`Message ${messageId} deleted successfully.`);
    return { status: "MessageDeletionSuccess" };
  } catch (error) {
    console.log(`Error deleting message ${messageId} :- ${error.message}`);
    return { message: `Unable to delete message.`, status: "MessageDeletionFail" };
  }
}

//------- check if the chatId belongs to the user's chats array ---------
const checkUser = async (userId, chatId) => {
  try {
    const userRef = firestoreDB.collection(usersCollectionName).doc(userId);
    const userDoc = await userRef.get();
    if (!userDoc.exists) return false;

    const chats = userDoc.data().chats;
    if (!chats.includes(chatId)) return false;

    return true;
  } catch (error) {
    console.error(`Error checking chat in user data :- ${error.message}`);
    return false;
  }
}


module.exports = { storeMessage, deleteMessage };