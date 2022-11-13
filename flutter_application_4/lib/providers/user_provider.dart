import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String endpoint = "https://identitytoolkit.googleapis.com/v1/";
  User user = User();
  setUser(User _user) {
    user = _user;
    notifyListeners();
  }

  Future<bool> updateUsuario(Map<String, String> formData) async {
    var urlDB = Uri.parse(
        'https://database-6ee9a-default-rtdb.firebaseio.com/Users/' +
            formData['localId']! +
            '.json');
    var responseDB = await http.put(urlDB, body: jsonEncode(formData));
    if (responseDB.statusCode == 200) {
      user.setUserData(jsonDecode(responseDB.body));
      notifyListeners();
      return true;
    }
    return false;
  }
}
