import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/user.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  String endpoint = "https://identitytoolkit.googleapis.com/v1/";

  RegisterProvider() {
    print('iniciando register');
  }

  Future<bool> registrarUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        'accounts:signUp?key=AIzaSyCPKpPtP3V0IFRhBQY0IyB58L0G-SHwaco');
    var response = await http.post(url, body: jsonEncode(formData));

    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      var urlDB = Uri.parse(
          'https://database-6ee9a-default-rtdb.firebaseio.com/Users/' +
              usuario.localId! +
              '.json');
      var responseDB = await http.put(urlDB,
        body: jsonEncode({
          'name': formData['name'], 
          'lastname': formData['lastname']
        })
      );
      if (responseDB.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
