const admin = require("firebase-admin");
const { firestoreDB } = require("../firebaseConfig");
const { chatCollectionName, messageCollectionName, userCollectionName } = require("../variableNames");

//---------------------- store message --------------------------------
const storeMessage = async (senderId, message, chatId) => {
  const correctUser = checkUser(senderId, chatId);
  if (!correctUser) {
    return { message: `User ${senderId} doesn't relate with chat ${chatId}.`, status: "MessageSendingFail" };
  }

  const chatRef = firestoreDB.collection(chatCollectionName).doc(chatId);
  const messageCollectionRef = chatRef.collection(messageCollectionName);

  // store message in database with timestamp
  try {
    const timeStamp = admin.firestore.FieldValue.serverTimestamp();
    const messageId = await messageCollectionRef.add({
      sender: senderId,
      message: message,
      time: timeStamp
    });

    return { timeStamp, message: `Added message ${messageId} to chat ${chatId}`, status: "MessageSendingSuccess" };
  } catch (error) {
    console.error(`Error storing message :- ${error.message}`);
    return { message: `Unable to send message.`, status: "MessageSendingFail" };
  }
}


//--------------- delete message given chatId --------------------------
const deleteMessage = async (userId, chatId, messageId) => {
  const correctUser = checkUser(userId, chatId);
  if (!correctUser) {
    return { message: `User ${senderId} doesn't relate with chat ${chatId}.`, status: "MessageSendingFail" };
  }

  const chatRef = firestoreDB.collection(chatCollectionName).doc(chatId);
  const messageRef = chatRef.collection(messageCollectionName).doc(messageId);

  try{
    await messageRef.delete();
    console.log(`Message ${messageId} deleted successfully.`);
    return { message: `Message ${messageId} deleted successfully.`, status: "MessageDeletionSuccessful" };
  } catch (error) {
    console.log(`Error deleting message ${messageId} :- ${error.message}`);
    return { message: `Unable to delete message.`, status: "MessageDeletionFail" };
  }
}

//------- check if the chatId belongs to the user's chats array ---------
const checkUser = async (userId, chatId) => {
  try {
    const userRef = firestoreDB.collection(userCollectionName).doc(senderId);
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