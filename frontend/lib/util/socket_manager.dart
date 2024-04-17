import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  static Socket? socket;

  static void initSocket(String chatId) {
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

    socket?.on("onMessage", (msg) => {print(msg)});
  }

  static void sendMessage(Map<String, Object?> message) {
    print(message);
    socket?.emit("msg", message);
  }

  static void receiveMessage() {}
  // static void disposeSocket() {}
}
