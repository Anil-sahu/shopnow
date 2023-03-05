import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shopnow/controllers/ProductController.dart';

class CustomeTextFields extends StatefulWidget {
  TextEditingController? value;
  String? hintText;
  IconData? icon;
  CustomeTextFields({super.key, this.value, this.hintText, this.icon});

  @override
  State<CustomeTextFields> createState() => _CustomeTextFieldsState();
}

class _CustomeTextFieldsState extends State<CustomeTextFields> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none),
      onTap: () {
        Get.find<ProductController>().startSearch();
      },
      onSubmitted: (value) {
        Get.find<ProductController>().searchProducts(value);
      },
    );
  }
}
