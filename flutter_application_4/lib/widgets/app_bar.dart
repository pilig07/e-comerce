import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/user.dart';

getAppBar(BuildContext context, String name, User user) {
  String initials = user.name!.substring(0, 1) + user.lastname!.substring(0, 1);
  return AppBar(
    title: Text(name),
    backgroundColor: Colors.purple,
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, 'profile');
        },
        child: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(initials),
        ),
      ),
      const SizedBox(
        width: 20,
      )
    ],
  );
}
