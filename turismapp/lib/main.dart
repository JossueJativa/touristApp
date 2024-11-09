import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismapp/providers/push_notification.dart';
import 'package:turismapp/screens/cart.dart';
import 'package:turismapp/screens/home.dart';
import 'package:turismapp/screens/login.dart';
import 'package:turismapp/screens/payment.dart';
import 'package:turismapp/screens/product.dart';
import 'package:turismapp/screens/products.dart';
import 'package:turismapp/screens/register.dart';
import 'package:turismapp/screens/traductor.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final getPref = prefs.getString('access');

    if (getPref == null) {
    } else {
      runApp(const MyApp(initialPage: '/home'));
    }
  } catch (e) {
    print('Firebase initialization error: $e');
  }
}

class MyApp extends StatefulWidget {
  final String initialPage;
  const MyApp({super.key, required this.initialPage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    final pushProvider = PushNotification();
    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialPage,
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/home': (context) => const Home(),
        '/traductor': (context) => const Traductor(),
        '/cart': (context) => const Cart(),
        '/payment': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return Payment(
            cartItems: args['cartItems'] as List<Map<String, dynamic>>,
            total: args['total'] as double,
          );
        },
        '/products': (context) => Products(
            categoryId: ModalRoute.of(context)!.settings.arguments as int),
        '/product': (context) => Product(
            productId: ModalRoute.of(context)!.settings.arguments as int),
      },
    );
  }
}
