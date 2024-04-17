import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  static Socket? socket;

  static void initSocket(String chatId, Function(dynamic) updateMessageList) {
    socket = io('http://10.0.2.2:8000', <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
      'auth': {'id': chatId}
    });

    socket?.connect();

    socket?.onConnectError((data) => print(data));
    socket?.onConnect(
        (data) => {print("Connected socket"), socket?.emit("join", chatId)});
    print(socket?.connected);

    socket?.on("onMessage",
        (msg) => {print("receiving: $msg"), updateMessageList(msg)});

    socket?.onDisconnect((data) => print("Disconnected!"));
  }

  static void sendMessage(
      Map<String, Object?> message, Function(dynamic) updateMessageList) {
    print(message);
    socket?.emit("emitMessage", message);
    updateMessageList(message);
  }

  static void receiveMessage() {}
  // static void disposeSocket() {}
}
