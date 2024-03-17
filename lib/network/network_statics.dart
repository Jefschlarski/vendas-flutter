class NetWorkStatics {
  final String _baseUrl = "http://192.168.2.119:3000";
  String get baseUrl {
    return _baseUrl;
  }

  String createUrl(String path) {
    return "$baseUrl$path";
  }
}
