import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late String _id;
  late String _email;

  String get id => _id;
  String get email => _email;

  void setUser(String id, String email) {
    _id = id;
    _email = email;
    notifyListeners();
  }
}
