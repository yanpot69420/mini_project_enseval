import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/Repository.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/model/product.dart';
import 'package:mini_project/widget_builder/text_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? choose;

  @override
  void initState() {
    super.initState();
    RepositoryController.fetchProducts('https://dummyjson.com/products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 249, 216),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: const Heading(text: 'PRODUCTS'),
              alignment: Alignment.topLeft,
            ),
            const SizedBox(height: 20),
            Container(
              child: DropButton(),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 50),
            Expanded(child: ProductGrid())
          ],
        ),
      ),
    );
  }
}

class DropButton extends StatefulWidget {
  const DropButton({super.key});

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: RepositoryController.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<String> _data = snapshot.data!;
          return Container(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton(
                dropdownColor: Colors.white,
                hint: BoldText(text: 'Categories'),
                value: selected,
                underline: SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: _data.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: BoldText(text: item),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    selected = newVal;
                  });
                  RepositoryController.fetchProducts(
                      'https://dummyjson.com/products/category/$newVal');
                }),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          mainAxisExtent: 256,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ItemInList(product: RepositoryController.prods[index]);
        },
        itemCount: RepositoryController.prods.length,
      ),
    );
  }
}

class ItemInList extends StatelessWidget {
  const ItemInList({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 125,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              child: Column(
                children: [
                  Text(
                    '${product.title}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('\$ ${product.price}'),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        product.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ]),
      ),
      onTap: () {
        Get.toNamed('/detail', arguments: product.id);
      },
    );
  }
}
