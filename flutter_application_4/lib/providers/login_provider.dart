import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/user.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  String endpoint = "https://identitytoolkit.googleapis.com/v1/";
  LoginProvider() {
    print('iniciando loginp');
  }

  Future<User?> loginUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        'accounts:signInWithPassword?key=AIzaSyCPKpPtP3V0IFRhBQY0IyB58L0G-SHwaco');
    var response = await http.post(url, body: jsonEncode(formData));

    if (response.statusCode == 200) {
      var usario = User.fromJson(jsonDecode(response.body));
      var urlDB = Uri.parse(
          'https://database-6ee9a-default-rtdb.firebaseio.com/Users/' +
              usario.localId! +
              '.json');
      var responseDB = await http.get(urlDB);
      if (responseDB.statusCode == 200) {
        usario.setUserData(jsonDecode(responseDB.body));
        return usario;
      }
    }
    return null;
  }
}
