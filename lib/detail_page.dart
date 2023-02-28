import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/repository.dart';
import 'package:mini_project/model/product.dart';
import 'package:mini_project/widget_builder/list_widget.dart';
import 'package:mini_project/widget_builder/text_widget.dart';
import 'package:mini_project/widget_builder/what_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int itemID = Get.arguments ?? 0;
    if (itemID != 0) {
      return FutureBuilder<Product>(
        future: RepositoryController.fetchDetail(itemID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Product _product = snapshot.data!;
            return Scaffold(
              backgroundColor: Color.fromARGB(255, 215, 249, 216),
              body: Container(
                height: double.infinity,
                margin: const EdgeInsets.all(40),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/green_bg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Heading(text: _product.title),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.8,
                                        blurRadius: 2,
                                        offset: Offset(0, 3))
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DetailHero(thumbnail: _product.thumbnail),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                height: 100,
                                child: ListImageH(list: _product.images)),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.vertical,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Heading5(text: 'Brand: ${_product.brand}'),
                                SizedBox(
                                  height: 15,
                                ),
                                Heading5(
                                    text: 'Category: ${_product.category}'),
                                SizedBox(
                                  height: 15,
                                ),
                                Heading5(text: 'Price: \$${_product.price}'),
                                SizedBox(
                                  height: 15,
                                ),
                                Heading5(
                                    text:
                                        'Discount: ${_product.discountPercentage} %'),
                                SizedBox(
                                  height: 15,
                                ),
                                Heading5(text: 'Stock: ${_product.stock}'),
                                SizedBox(
                                  height: 15,
                                ),
                                Heading5(
                                    text: 'Rating: ${_product.rating} / 5'),
                                SizedBox(
                                  height: 5,
                                ),
                                DetailRating(rate: _product.rating),
                                SizedBox(
                                  height: 25,
                                ),
                                Heading5(text: 'Description:'),
                                SizedBox(
                                  height: 5,
                                ),
                                Heading5(text: _product.description)
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return Scaffold(
        body: Center(
          child: Heading(text: 'Invalid ID!'),
        ),
      );
    }
  }
}
