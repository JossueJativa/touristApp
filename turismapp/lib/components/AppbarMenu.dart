import 'package:flutter/material.dart';
import 'package:turismapp/components/ButtonRectangle.dart';
import 'package:turismapp/components/CircularButton.dart';
import 'package:turismapp/components/notifications.dart';
import 'package:turismapp/controller/userController.dart';

class AppbarMenu extends StatelessWidget implements PreferredSizeWidget {
  const AppbarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        CircularButton(
          icon: Icons.logout,
          color: const Color(0xFF80DEEA),
          width: 45,
          height: 45,
          onPressed: () async {
            final response = await logout();

            if (response) {
              Notifications(
                title: 'Sesión cerrada',
                context: context,
                color: Colors.green,
              );
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            } else {
              Notifications(
                title: 'Error al cerrar sesión',
                context: context,
                color: Colors.red,
              );
            }
          },
        ),

        const SizedBox(width: 25),

        ButtonRectangle(
          text: 'Traductor',
          color: const Color(0xFF80DEEA),
          width: 200,
          height: 40,
          onPressed: () {
            Navigator.pushNamed(context, '/traductor');
          },
        ),

        const SizedBox(width: 25),

        CircularButton(
          icon: Icons.shopping_cart, 
          color: const Color(0xFF80DEEA),
          width: 45,
          height: 45,
          onPressed: () {
            
          },
        ),

        const SizedBox(width: 10),

        CircularButton(
          icon: Icons.person,
          color: const Color(0xFF80DEEA),
          width: 45,
          height: 45,
          onPressed: () {
            
          },
        ),

        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
