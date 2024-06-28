import 'package:flutter/material.dart';
import 'package:turismapp/controller/getCatrgories.dart';

class FooterBar extends StatefulWidget {
  const FooterBar({Key? key}) : super(key: key);

  @override
  _FooterBarState createState() => _FooterBarState();
}

class _FooterBarState extends State<FooterBar> {
  List<Map<String, dynamic>> categories = [];
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final fetchedCategories = await getCategories();
    setState(() {
      categories = fetchedCategories;
    });
  }

  void animateSelection(int index) {
    setState(() {
      selectedIndex = index;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.87,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Categorías', style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        animateSelection(index);
                        final id = category['id'];
                        print('Categoría seleccionada: $id');
                      },
                      child: AnimatedOpacity(
                        opacity: selectedIndex == index ? 0.5 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          color: selectedIndex == index ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                          child: ListTile(
                            title: Text(
                              category['name'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
