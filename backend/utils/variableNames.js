const collectionNames = {
  CHATS: "chats",
  USERS: "users",
  MESSAGES: "messages"
};

const statusCodes = {
  SERVER_ERROR: "ServerError",
  //user
  USER_FOUND: "UserFound",
  USER_NOT_FOUND: "UserNotFound",
  //chat
  CHAT_FOUND: "ChatFound",
  CHAT_NOT_FOUND: "ChatNotFound",
  CHAT_NOT_IN_USER: "ChatNotInUser",
  // message
  MESSAGE_SEND_SUCCESS: "MessageSendSuccess",
  MESSAGE_SEND_FAIL: "MessageSendFail",
  APPROPRIATE_MESSAGE: "AppropriateMessage",
  INAPPROPRIATE_MESSAGE: "InappropriateMessage"
};

module.exports = { collectionNames, statusCodes };
