import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../../models/product/producModel.dart';

class ProductCard extends StatefulWidget {
  var product;
  ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Theme.of(context).backgroundColor, Colors.white]),
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(widget.product.thumbnail))),
          // child: Image.network(
          //   widget.product.thumbnail!,
          //   width: 100,
          //   height: 100,
          // ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.product.title!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "\$ ${widget.product.price}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Row(
        children: [],
      )
    ]);
  }
}
