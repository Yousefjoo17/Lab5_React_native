import 'package:flutter/material.dart';
import 'package:testapp/list_items_view.dart';
import 'package:testapp/service.dart';
import 'package:testapp/show_snack_bar.dart';
import 'package:testapp/widgets/Custom_button.dart';
import 'package:testapp/widgets/Custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? userName;
  String? password;
  List<Map<String, dynamic>> data = [];
  bool isLoading = true; //

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> fetchedData =
          await NewsService().getUserInfo();
      print(fetchedData);
      setState(() {
        data = fetchedData;
        isLoading = false; // Data loaded
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      showmySnackBar(context, "Failed to fetch user data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching data
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  hinttext: "Username",
                  onchanged: (p0) {
                    userName = p0;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  obscureText: true,
                  hinttext: "Password",
                  onchanged: (p0) {
                    password = p0;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Login",
                  ontap: () {
                    if (userName == null ||
                        password == null ||
                        userName!.isEmpty ||
                        password!.isEmpty) {
                      showmySnackBar(
                          context, "Please enter username and password.");
                      return;
                    }

                    if (authenticateUser(data, userName!, password!)) {
                      print("User found");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ListItemView(),
                        ),
                      );
                    } else {
                      if (userNameFound(data, userName!)) {
                        showmySnackBar(context, "Password not matched");
                      } else {
                        showmySnackBar(context, "User not found");
                      }
                    }
                  },
                  color: Colors.black,
                )
              ],
            ),
    );
  }
}

bool authenticateUser(
    List<Map<String, dynamic>> users, String username, String password) {
  return users.any(
      (user) => user["username"] == username && user["password"] == password);
}

bool userNameFound(List<Map<String, dynamic>> users, String username) {
  return users.any((user) => user["username"] == username);
}
