import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/ProductController.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({super.key});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 204,
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Obx(
          () => Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey,
            enabled: Get.find<ProductController>().isLoading.value,
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (_, __) => Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    // crossAxisAlign///////ment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 40,
                              // color: Colors.white,

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              // color: Colors.white,

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: CarouselSlider(
                          items: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                            )
                          ],
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            height: 140,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          itemCount: 100,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemBuilder: (context, index) {
                            return Expanded(
                              child: Card(
                                elevation: 10,
                                shadowColor:
                                    const Color.fromARGB(75, 131, 131, 131),
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: index % 2 == 0 ? 200 : 220,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
