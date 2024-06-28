import 'package:flutter/material.dart';
import 'package:turismapp/components/AppbarMenu.dart';
import 'package:turismapp/components/FooterBar.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;

  const MainScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppbarMenu(),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: body,
          ),
          const FooterBar(),
        ],
      ),
    );
  }
}
