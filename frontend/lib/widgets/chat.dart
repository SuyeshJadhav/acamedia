class Chat {
  Chat({
    required this.name,
    // required this.imageUrl,
    required this.recentMessage,
    this.hasUnseenMessages = false,
  });

  final bool hasUnseenMessages;
  // final String imageUrl;
  final String name;
  final String recentMessage;
}
