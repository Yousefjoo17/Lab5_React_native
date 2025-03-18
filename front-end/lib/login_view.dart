import 'package:flutter/material.dart';
import 'package:testapp/list_items_view.dart';
import 'package:testapp/show_snack_bar.dart';
import 'package:testapp/util/API_service.dart';
import 'package:testapp/util/assets_data.dart';
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
  bool isLoading = false;

  Future<void> login() async {
    if (userName == null ||
        password == null ||
        userName!.isEmpty ||
        password!.isEmpty) {
      showmySnackBar(context, "Please enter username and password.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    var userData = await AuthService().loginUser(userName!, password!);

    setState(() {
      isLoading = false;
    });

    if (userData != null) {
      print("User logged in: $userData");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListItemView(),
        ),
      );
    } else {
      showmySnackBar(context, "Invalid username or password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // Show loader when logging in
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsData.kShopping, // Path to the image
                    width: 150, // Adjust width as needed
                    height: 150, // Adjust height as needed
                  ),
                  const SizedBox(height: 28),
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
                    ontap: login, // Call login function
                    color: Colors.black,
                  ),
                ],
              ),
      ),
    );
  }
}
