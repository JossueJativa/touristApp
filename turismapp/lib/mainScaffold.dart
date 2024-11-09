import 'package:flutter/material.dart';
import 'package:turismapp/components/AppbarMenu.dart';
import 'package:turismapp/components/FooterBar.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;

  const MainScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppbarMenu(),
      body: Stack(
        children: <Widget>[
          SizedBox(
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
