import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  static Socket? socket;

  static Socket? initSocket(String chatId) {
    socket = io('http://10.0.2.2:8000', <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
      'auth': {'id': chatId}
    });

    socket?.connect();

    print(socket?.connected);
    socket?.onConnectError((data) => print(data));
    socket?.onConnect(
        (data) => {print("Connected"), socket?.emit("join", chatId)});

    return socket;
  }

  static void sendMessage(Map<String, Object?> message) {
    socket?.emit("emitMessage", message);
  }

  static void receiveMessage() {}

  // static void disposeSocket() {}
}
