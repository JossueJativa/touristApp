import 'package:flutter/material.dart';
import 'package:turismapp/components/ButtonForm.dart';
import 'package:turismapp/components/InputForm.dart';
import 'package:turismapp/components/TextButtonForm.dart';
import 'package:turismapp/components/notifications.dart';
import 'package:turismapp/controller/userController.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Imagen de background
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/LOGO_MOCHI_GO.png',
                      width: 200, height: 200, fit: BoxFit.fill),
                  InputForm(
                      icon: Icons.person,
                      hint: "Username",
                      isPassword: false,
                      controller: _usernameController),
                  InputForm(
                      icon: Icons.email,
                      hint: "Email",
                      isPassword: false,
                      controller: _emailController),
                  InputForm(
                      icon: Icons.lock,
                      hint: "Password",
                      isPassword: true,
                      controller: _passwordController),
                  InputForm(
                      icon: Icons.lock,
                      hint: "Confirm Password",
                      isPassword: true,
                      controller: _confirmPasswordController),
                  ButtonForm(
                      text: "Register",
                      principalColor: Colors.white,
                      onPressedColor: Colors.grey,
                      textColor: Colors.black,
                      onPressed: () async {
                        final result = await register(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );

                        if (result["error"] != null) {
                          Notifications(
                            title: result["error"],
                            context: context,
                            color: Colors.red,
                          );
                        } else {
                          Notifications(
                            title: "User created successfully",
                            context: context,
                            color: Colors.green,
                          );
                          Navigator.pushNamed(context, '/login');
                        }
                      }),
                  TextButtonForm(
                    text: "Sign in",
                    onPressed: () => {Navigator.pushNamed(context, '/login')},
                    textColor: Colors.black,
                    fontSize: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
