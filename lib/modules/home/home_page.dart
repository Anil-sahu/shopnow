import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/ProductController.dart';
import '../productDatail/details.dart';
import '../widgets/CustomeTextFileds.dart';
import '../widgets/ProductCard.dart';
import '../widgets/coursoleCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedCategory = "";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    padding: const EdgeInsets.only(left: 0, right: 12),
                    width: width - 80,
                    height: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              width: width - 150,
                              height: 50,
                              child: CustomeTextFields(
                                hintText: "Search.",
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.find<ProductController>().isSearch.value
                                ? Get.find<ProductController>().stopSearch()
                                : Get.find<ProductController>().startSearch();
                          },
                          child: Obx(
                            () => Icon(
                              Get.find<ProductController>().isSearch.value
                                  ? Icons.close
                                  : Icons.search_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.find<ProductController>().fetchGategory();
                    Get.find<ProductController>().filter();
                  },
                  child: Obx(
                    () => AnimatedContainer(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(8),
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width:
                                    Get.find<ProductController>().isFilter.value
                                        ? 2
                                        : 0,
                                color: Theme.of(context).selectedRowColor),
                            borderRadius: BorderRadius.circular(12),
                            color: Get.find<ProductController>().isFilter.value
                                ? Theme.of(context).selectedRowColor
                                : Colors.white),
                        child: Obx(() {
                          return SvgPicture.asset("assets/filter.svg",
                              width: 15,
                              height: 15,
                              colorFilter: ColorFilter.mode(
                                  Get.find<ProductController>().isFilter.value
                                      ? Colors.white
                                      : Theme.of(context).selectedRowColor,
                                  BlendMode.srcIn),
                              semanticsLabel: 'A red up arrow');
                        })),
                  ),
                )
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Get.find<ProductController>().isFilter.value
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    child: Expanded(
                      child: Obx(() {
                        return ListView.builder(
                            itemCount:
                                Get.find<ProductController>().category.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCategory =
                                        Get.find<ProductController>()
                                            .category[index];
                                  });
                                  Get.find<ProductController>()
                                      .getProductBycate(selectedCategory);
                                  print(Get.find<ProductController>()
                                      .getCategoryProduct
                                      .value);
                                },
                                child: Obx(
                                  () => AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    margin: const EdgeInsets.only(
                                        left: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: selectedCategory ==
                                                    Get.find<
                                                            ProductController>()
                                                        .category[index]
                                                ? 2
                                                : 0,
                                            color: Theme.of(context)
                                                .selectedRowColor),
                                        borderRadius: BorderRadius.circular(12),
                                        color: selectedCategory ==
                                                Get.find<ProductController>()
                                                    .category[index]
                                            ? Theme.of(context).selectedRowColor
                                            : Colors.white),
                                    child: Center(
                                        child: Text(
                                      Get.find<ProductController>()
                                          .category[index],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  )
                : Column(
                    children: [
                      CarouselSlider(
                        items: const [CorouleCard(), CorouleCard()],
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          height: 140,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: Obx(
            () => MasonryGridView.count(
              itemCount: Get.find<ProductController>().products.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetail(
                          product:
                              Get.find<ProductController>().products[index],
                        ));
                  },
                  child: Expanded(
                    child: Hero(
                      tag: Get.find<ProductController>().products[index].id,
                      child: Card(
                        elevation: 10,
                        shadowColor: const Color.fromARGB(75, 131, 131, 131),
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: index % 2 == 0 ? 200 : 220,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: ProductCard(
                              product: Get.find<ProductController>()
                                  .products[index]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
    ;
  }
}
