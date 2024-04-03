class Chat {
  Chat({
    required this.name,
    required this.chatId,
    required this.receiverId,
    // required this.imageUrl,
    required this.recentMessage,
    this.hasUnseenMessages = false,
  });

  final bool hasUnseenMessages;
  // final String imageUrl;
  final String name, receiverId, chatId, recentMessage;
}
