import 'package:flutter/material.dart';
import 'package:turismapp/components/InputForm.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Añade color de fondo para contrastar con el texto blanco
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InputForm(
                label: "Usuario:",
                hint: "Usuario",
                isPassword: false,
                controller: usernameController,
              ),
              const SizedBox(height: 20),
              // Puedes agregar más InputForms o botones aquí según sea necesario
            ],
          ),
        ),
      ),
    );
  }
}
