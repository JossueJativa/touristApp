import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismapp/components/ButtonForm.dart';
import 'package:turismapp/components/InputForm.dart';
import 'package:turismapp/components/notifications.dart';
import 'package:turismapp/controller/decodeJWT.dart';
import 'package:turismapp/controller/paymen.dart';
import 'package:turismapp/mainScaffold.dart';

class Payment extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double total;
  const Payment({Key? key, required this.cartItems, required this.total}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Tarjeta.png',
                width: 500,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputForm(
                      icon: Icons.credit_card,
                      controller: _cardNumberController,
                      hint: 'Número de tarjeta',
                      isPassword: false,
                    ),
                    const SizedBox(height: 10),
                    InputForm(
                      icon: Icons.lock,
                      controller: _cvvController,
                      hint: 'CVV',
                      isPassword: true,
                    ),
                    InputForm(
                      icon: Icons.person,
                      controller: _nameController,
                      hint: 'Nombre del titular',
                      isPassword: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Datos del usuario:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputForm(
                      icon: Icons.person,
                      controller: _firstNameController,
                      hint: 'Nombre',
                      isPassword: false,
                    ),
                    InputForm(
                      icon: Icons.person,
                      controller: _lastNameController,
                      hint: 'Apellido',
                      isPassword: false,
                    ),
                    InputForm(
                      icon: Icons.email,
                      controller: _emailController,
                      hint: 'Correo',
                      isPassword: false,
                    ),
                    InputForm(
                      icon: Icons.phone,
                      controller: _phoneController,
                      hint: 'Teléfono',
                      isPassword: false,
                    ),
                    InputForm(
                      icon: Icons.location_on,
                      controller: _locationController,
                      hint: 'Dirección',
                      isPassword: false,
                    ),
                    const SizedBox(height: 10),
                    ButtonForm(
                      text: 'Pagar',
                      onPressed: () async {
                        if (_cardNumberController.text.isEmpty ||
                            _cvvController.text.isEmpty ||
                            _nameController.text.isEmpty ||
                            _firstNameController.text.isEmpty ||
                            _lastNameController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _locationController.text.isEmpty) {
                          
                          Notifications(
                            title: 'Por favor, llene todos los campos',
                            context: context,
                            color: Colors.red,
                          );
                          return;
                        }
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        final String? getAccess = prefs.getString('access');
                        final accessJWT = decodeJWT(getAccess!);
                        final int userId = accessJWT['user_id'];

                        final bool paymentSuccessful = await payment(
                          widget.total,
                          userId,
                          _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _locationController.text,
                          _phoneController.text,
                          widget.cartItems,
                        );
                        if (paymentSuccessful) {
                          Notifications(
                            title: 'Pago exitoso',
                            context: context,
                            color: Colors.green,
                          );

                          prefs.remove('cart');
                          Navigator.popAndPushNamed(context, '/home');
                        } else {
                          // Maneja el error del pago (mostrar mensaje, etc.)
                          print('Error en el pago');
                        }
                      },
                      onPressedColor: Colors.black,
                      principalColor: Colors.green,
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
