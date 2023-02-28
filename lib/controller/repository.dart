import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mini_project/model/product.dart';
import 'package:http/http.dart' as http;

class RepositoryController extends GetxController {
  static RxList<Product> prods = <Product>[].obs;

  static Future<void> fetchProducts(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      prods.clear();
      Iterable loop = json.decode(response.body)['products'];

      prods = RxList<Product>.from(loop.map((e) => Product.fromJson(e)));
      prods.refresh();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<Product> fetchDetail(int id) async {
    final String url = 'https://dummyjson.com/products/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var detail = Product.fromJson(json.decode(response.body));
      return detail;
    } else {
      throw Exception('Failed to fetch detail of product!');
    }
  }

  static Future<List<String>> getCategories() async {
    final String url = 'https://dummyjson.com/products/categories';
    List<String> cat = [];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonbody = json.decode(response.body);
      for (var item in jsonbody) {
        cat.add(item);
      }
      return cat;
    } else {
      throw Exception('Failed to fetch categories list!');
    }
  }
}
