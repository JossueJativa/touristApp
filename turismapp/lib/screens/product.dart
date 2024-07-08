import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismapp/components/ButtonForm.dart';
import 'package:turismapp/components/TextArea.dart';
import 'package:turismapp/controller/getProducts.dart';
import 'package:turismapp/mainScaffold.dart';

class Product extends StatefulWidget {
  final int productId;
  const Product({super.key, required this.productId});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final TextEditingController _description = TextEditingController();
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
      child: FutureBuilder<Map<String, dynamic>>(
        future: getProduct(widget.productId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            _description.text = product['description'];
            final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
            return Padding(
              padding: const EdgeInsets.only(
                  top: 105.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    child: Image.network(
                      product['image'],
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      '${product['name']}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextArea(controller: _description, editable: false),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Precio: \$${product['price']}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonForm(
                      text: 'Agregar al carrito',
                      onPressed: () async {
                        final SharedPreferences prefs = await _prefs;
                        final List<String> cart = prefs.getStringList('cart') ?? [];
                        cart.add(product['id'].toString());
                        await prefs.setStringList('cart', cart);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto agregado al carrito'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      principalColor: const Color.fromARGB(255, 45, 237, 70),
                      onPressedColor: const Color.fromARGB(255, 45, 237, 70),
                      textColor: Colors.black,
                      key: const Key('translateButton'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonForm(
                      text: 'Volver al listado',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      principalColor: const Color(0xFF80DEEA),
                      onPressedColor: const Color(0xFF80DEEA),
                      textColor: Colors.black,
                      key: const Key('translateButton'),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
