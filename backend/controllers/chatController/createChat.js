const { firestoreDB } = require("../../utils/firebaseConfig");
const { getTimeStamp } = require( "../../utils/generalHelperFunctions" );
const { collectionNames, statusCodes } = require("../../utils/variableNames");
const { getUserDataById } = require("../userController/getUserData");
const { addChatToUser, getChatId } = require("./chatHelperFunctions");

/*********************************************************
                    Create Chat
*********************************************************/
const createChat = async (user1Id, user2Id) => {
  //make sure that user1 and user2 actually exist
  const user1Exists = await getUserDataById(user1Id);
  const user2Exists = await getUserDataById(user2Id);
  if (
    user1Exists.status === statusCodes.SERVER_ERROR ||
    user2Exists.status === statusCodes.SERVER_ERROR
  )
    return {
      message: `Error creating new chat between ${user1Id} and ${user2Id}`,
      status: 500
    };
  else if (user1Exists.status === statusCodes.USER_NOT_FOUND)
    return {
      message: `User with ID ${user1Id} doesn't exist.`,
      status: 404
    };
  else if (user2Exists.status === statusCodes.USER_NOT_FOUND)
    return {
      message: `User with ID ${user2Id} doesn't exist.`,
      status: 404
    };

  const existingChat = await getChatId(user1Id, user2Id);

  if (existingChat.status === statusCodes.CHAT_FOUND)
    return {
      message: `Chat between ${user1Id} and ${user2Id} exists already`,
      status: 400
    };
  else if (existingChat.status === collectionNames.SERVER_ERROR)
    return {
      message: "Error creating new chat",
      status: 500
    };

  let chatId;

  //create new chat and add the user1 and user2 as members
  try {
    const chatCollectionRef = firestoreDB.collection(collectionNames.CHATS);
    const chatDoc = await chatCollectionRef.add({
      users: [user1Id, user2Id],
      timeStamp: getTimeStamp()
    });
    chatId = chatDoc.id;
  } catch (error) {
    console.error(`Error creating new chat :- \n${error.message}`);
    return {
      message: `Unable to create new chat for ${user1Id} and ${user2Id}`,
      status: 500
    };
  }

  //add chat to user1 and user2 chats array
  const chatAddedToUser1 = await addChatToUser(chatId, user1Id);
  if (!chatAddedToUser1)
    return {
      message: `Error creating new chat`,
      status: 500
    };
  const chatAddedToUser2 = await addChatToUser(chatId, user2Id);
  if (!chatAddedToUser2) {
    return {
      message: `Error creating new chat`,
      status: 500
    };
  }

  return {
    chatId,
    message: `Added chat ${chatId} to users ${user1Id} and ${user2Id}`,
    status: 200
  };
};

module.exports = createChat;
