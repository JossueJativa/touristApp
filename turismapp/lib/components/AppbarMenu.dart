import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppbarMenu extends StatelessWidget {
const AppbarMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'MOCHI GO!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      )
    );
  }
}