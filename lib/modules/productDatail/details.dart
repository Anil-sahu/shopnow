import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopnow/controllers/ProductController.dart';
import 'package:shopnow/localstorage/sharePreferences.dart';

class ProductDetail extends StatefulWidget {
  var product;
  String? fave;
  ProductDetail({super.key, this.product, this.fave});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedIndex = 0;
  SharePreferenceService sps = SharePreferenceService();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                sps.saveToFavorite(widget.fave != null
                    ? widget.product['id']
                    : widget.product.id);
                Get.find<ProductController>().getFaverit();
              },
              icon: Obx(
                () => Get.find<ProductController>().favoriteList.contains(
                        widget.fave != null
                            ? widget.product['id'].toString()
                            : widget.product.id.toString())
                    ? const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        size: 30,
                        color: Colors.red,
                      ),
              ))
        ],
      ),
      body: Hero(
          tag: widget.fave != null ? widget.product['id'] : widget.product.id,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      width: width,
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(widget.fave != null
                                  ? widget.product['images'][selectedIndex]
                                  : widget.product.images[selectedIndex])),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(100))),
                    ),
                    SizedBox(
                      height: 70,
                      width: width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            widget.fave != null
                                ? widget.product['images'].length
                                : widget.product.images.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    width: selectedIndex == index ? 60 : 40,
                                    height: selectedIndex == index ? 60 : 40,
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.fave != null
                                                    ? widget.product['images']
                                                        [index]
                                                    : widget.product
                                                        .images[index])),
                                        border: Border.all(
                                            width:
                                                selectedIndex == index ? 3 : 0,
                                            color: selectedIndex == index
                                                ? Theme.of(context)
                                                    .selectedRowColor
                                                : Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: width / 2,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    widget.fave != null
                                        ? widget.product['title']
                                        : widget.product.title,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        widget.fave != null
                                            ? widget.product['rating']
                                                .toString()
                                            : widget.product.rating.toString(),
                                        style: const TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            AnimatedContainer(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(20),
                              duration: const Duration(milliseconds: 500),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      widget.fave != null
                                          ? "\$ ${widget.product['price']}"
                                          : "\$ ${widget.product.price}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 15, 46, 71),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    widget.fave != null
                                        ? "${widget.product['discountPercentage']}% OFF"
                                        : "${widget.product.discountPercentage}% OFF",
                                    style: TextStyle(
                                      color: Theme.of(context).selectedRowColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Description",
                            maxLines: 5,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            widget.fave != null
                                ? widget.product['description']
                                : widget.product.description,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              FloatingActionButton.extended(
                  heroTag: "card",
                  backgroundColor: const Color.fromARGB(255, 15, 46, 71),
                  onPressed: () {},
                  label: Stack(alignment: Alignment.topRight, children: [
                    SvgPicture.asset(
                      "assets/card.svg",
                      color: Theme.of(context).selectedRowColor,
                      width: 30,
                      height: 30,
                    ),
                  ])),
              AnimatedContainer(
                margin: const EdgeInsets.only(bottom: 0, left: 10),
                padding: const EdgeInsets.all(5),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    color: Theme.of(context).selectedRowColor,
                    shape: BoxShape.circle),
                child: Obx(
                  () => Text(Get.find<ProductController>()
                      .addToCardList
                      .length
                      .toString()),
                ),
              )
            ],
          ),
          FloatingActionButton.extended(
              heroTag: "add to card",
              backgroundColor: const Color.fromARGB(255, 15, 46, 71),
              onPressed: () {
                sps.saveToCard(widget.fave != null
                    ? widget.product['id']
                    : widget.product.id);
              },
              label: Row(children: [
                Obx(() => Get.find<ProductController>().addToCardList.contains(
                        widget.fave != null
                            ? widget.product['id']
                            : widget.product.id.toString())
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add_rounded)),
                Obx(() => Get.find<ProductController>().addToCardList.contains(
                        widget.fave != null
                            ? widget.product['id']
                            : widget.product.id.toString())
                    ? const Text("Remove from Card")
                    : const Text("Add to card"))
              ])),
        ],
      ),
    );
  }
}
