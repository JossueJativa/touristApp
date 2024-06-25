import 'package:flutter/material.dart';
import 'package:turismapp/components/ButtonForm.dart';
import 'package:turismapp/components/InputForm.dart';
import 'package:turismapp/components/TextButtonForm.dart';
import 'package:turismapp/controller/userController.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      icon: Icons.lock,
                      hint: "Password",
                      isPassword: true,
                      controller: _passwordController),

                  ButtonForm(
                      text: "Login",
                      principalColor: Colors.white,
                      onPressedColor: Colors.grey,
                      textColor: Colors.black,
                      onPressed: () => {
                            login(
                              _usernameController.text,
                              _passwordController.text,
                            )
                          }),

                  TextButtonForm(
                    text: "Forgot your password?",
                    onPressed: () => {print("Forgot your password?")},
                    textColor: Colors.black,
                    fontSize: 15.0,
                  ),

                  TextButtonForm(
                    text: "Sign up",
                    onPressed: () => {
                      Navigator.pushNamed(context, '/register')
                    },
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
