import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismapp/controller/getProducts.dart';
import 'package:turismapp/mainScaffold.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final getcart = prefs.getStringList('cart');

    if (getcart == null) {
      setState(() {
        cartItems = [];
      });
    } else {
      // Limpiar la lista de items antes de cargar nuevos productos
      cartItems.clear();

      for (var car in getcart) {
        final carInt = int.parse(car);
        final product = await getProduct(carInt);
        setState(() {
          product['quantity'] = product['quantity'] ??
              1; // Asegurarse de que la cantidad esté inicializada
          cartItems.add(product);
        });
      }
    }
  }

  void updateCart(int index,
      {bool increment = true, bool decrement = false, bool remove = false}) {
    setState(() {
      if (increment) {
        cartItems[index]['quantity'] = (cartItems[index]['quantity'] ?? 1) + 1;
      } else if (decrement) {
        if (cartItems[index]['quantity'] > 1) {
          cartItems[index]['quantity'] -= 1;
        }
      } else if (remove) {
        cartItems.removeAt(index);
      }
      saveCart();
    });
  }

  Future<void> saveCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> cartIds =
        cartItems.map((item) => item['id'].toString()).toList();
    prefs.setStringList('cart', cartIds);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice +=
          double.parse(item['price'].toString()) * (item['quantity'] ?? 1);
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Background_login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = cartItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/product',
                                arguments: product['id']);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: Image.network(
                                          product['image'],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(
                                          product['name'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          'Precio: \$${product['price']}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  updateCart(index,
                                                      increment: false,
                                                      decrement: true,
                                                      remove: false);
                                                },
                                                icon: const Icon(Icons.remove),
                                              ),
                                              Text(
                                                  '${product['quantity'] ?? 1}'),
                                              IconButton(
                                                onPressed: () {
                                                  updateCart(index,
                                                      increment: true,
                                                      decrement: false,
                                                      remove: false);
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              updateCart(index,
                                                  increment: false,
                                                  decrement: false,
                                                  remove: true);
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${(double.parse(product['price'].toString()) * (product['quantity'] ?? 1)).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${calculateTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final List<Map<String, dynamic>> idQuantity = [];
                          for (var item in cartItems) {
                            idQuantity.add({
                              'id': item['id'],
                              'quantity': item['quantity'] ??
                                  1 // Asegurarse de que la cantidad no sea nula
                            });
                          }
                          final double total = calculateTotalPrice();
                          Navigator.pushNamed(context, '/payment', arguments: {
                            'cartItems': idQuantity,
                            'total': total,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text(
                          'Pagar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
