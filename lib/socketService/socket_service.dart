// socket_service.dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initializeSocket() {
    print('Initializing socket connection...');
    socket =
        IO.io('https://parking-system-3qkl.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('Connected to server');
      socket.emit('msg', 'Hello from Flutter!');
    });

    socket.on('sensorData', (data) {
      print('Recived sensor data $data');
    });

    socket.onConnectError((data) {
      print('Connection Error: $data');
    });

    socket.onConnectTimeout((data) {
      print('Connection Timeout: $data');
    });

    socket.onError((data) {
      print('Error: $data');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    socket.connect();
  }

  void dispose() {
    if (socket.connected) {
      socket.disconnect();
      print('server disconnected');
    }
  }
}
