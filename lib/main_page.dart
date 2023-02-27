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
      body: Column(
        children: [
          Container(
            child: const Heading(text: 'PRODUCTS'),
            margin: const EdgeInsets.only(top: 20, left: 30, right: 20),
            alignment: Alignment.topLeft,
          ),
          const SizedBox(height: 20),
          Container(
            child: DropButton(),
            margin: const EdgeInsets.only(left: 30, right: 20),
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: 50),

          Container(
              height: 575,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(10),
              child: ProductGrid())
          // ItemInList()
        ],
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
        if(snapshot.hasData)  {
          final List<String> _data = snapshot.data!;
          return Container(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10)
            ),
            child: DropdownButton(
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
                RepositoryController.fetchProducts('https://dummyjson.com/products/category/$newVal');
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
            maxCrossAxisExtent: 280,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: 280 ),
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
            Container(
              child: Image.network(
                product.thumbnail,
                height: 125,
                fit: BoxFit.cover,
                
              ),
              padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              child: Column(
                children: [
                  Text(
                    '${product.title}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600
                    ), ),
                  Text('\$ ${product.price}'),
                  const SizedBox(height: 15),
                  Container(
                    child: Text(
                      product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ]),
      ),
      onTap: () {
        Get.toNamed('/detail', arguments: product.id);
      },
    );
  }
}





