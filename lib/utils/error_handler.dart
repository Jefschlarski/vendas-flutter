import 'dart:io';

class ErrorHandler {
  static get(e) {
    if (e is SocketException) {
      return Exception("Erro ao tentar se conectar com o servidor");
    }
  }
}
