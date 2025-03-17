import 'package:flutter/material.dart';
import 'package:testapp/mydata.dart';
import 'package:testapp/widgets/Custom_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userName});
  final String userName;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? usersData = getUserInfo(users, widget.userName);

    if (usersData == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not found", style: TextStyle(fontSize: 20)),
        ),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Name", style: TextStyle(fontSize: 20)),
          CustomTextField(hinttext: usersData["name"] ?? ""),
          const SizedBox(height: 20),
          const Text("Username", style: TextStyle(fontSize: 20)),
          CustomTextField(hinttext: widget.userName),
          const SizedBox(height: 20),
          const Text("Email", style: TextStyle(fontSize: 20)),
          CustomTextField(hinttext: usersData["email"] ?? ""),
          const SizedBox(height: 20),
          const Text("Phone", style: TextStyle(fontSize: 20)),
          CustomTextField(hinttext: usersData["phone"] ?? ""),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

Map<String, dynamic>? getUserInfo(
    List<Map<String, dynamic>> users, String username) {
  var user = users.firstWhere(
    (user) => user["username"] == username,
  );
  return {
    "name": user["name"],
    "email": user["email"],
    "phone": user["phone"],
  };
}
