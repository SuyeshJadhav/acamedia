const collectionNames = {
  CHATS: "chats",
  USERS: "users",
  MESSAGES: "messages"
};

const statusCodes = {
  SERVER_ERROR: "ServerError",
  USER_FOUND: "UserFound",
  USER_NOT_FOUND: "UserNotFound",
  CHAT_FOUND: "ChatFound",
  CHAT_NOT_FOUND: "ChatNotFound",
  MESSAGE_SEND_SUCCESS: "MessageSendSuccess",
  MESSAGE_SEND_FAIL: "MessageSendFail"
};

module.exports = { collectionNames, statusCodes };
