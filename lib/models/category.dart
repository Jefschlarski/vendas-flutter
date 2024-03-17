class Category {
  late int _id;
  late String _name;

  int get id => _id;
  String get name => _name;

  Category fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    return this;
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'name': _name};
  }
}
