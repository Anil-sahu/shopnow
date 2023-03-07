import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product/producModel.dart';

class RemoteService {
  static var client = http.Client();

  static Future<Product?> fetchProduct() async {
    try {
      var res = await client.get(Uri.parse("https://dummyjson.com/products"));
      if (res.statusCode == 200) {
        var jsonString = res.body;
        return productFromJson(jsonString);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getProductCategory() async {
    var url = "https://dummyjson.com/products/categories";
    try {
      var response =
          await http.Client().get(Uri.parse(url)).whenComplete(() {});
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        return decode;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<Product?> searchProduct(product) async {
    var url = "https://dummyjson.com/products/search?q=$product";
    try {
      var response = await http.Client().get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        return productFromJson(response.body);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getProductByCategory(category) async {
    var url = "https://dummyjson.com/products/category/$category";
    try {
      var response =
          await http.Client().get(Uri.parse(url)).whenComplete(() {});
      var decode = jsonDecode(response.body);

      return productFromJson(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//-------------------------------Get Produc By ID----------------------//
  static getProduct(id) async {
    var url = "https://dummyjson.com/products/$id";
    try {
      var response =
          await http.Client().get(Uri.parse(url)).whenComplete(() {});
      var decode = jsonDecode(response.body);
      print(decode);
      return decode;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
