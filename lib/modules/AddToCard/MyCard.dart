import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopnow/modules/widgets/favoriteCard.dart';

import '../../controllers/ProductController.dart';
import '../productDatail/details.dart';
import '../widgets/ProductCard.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  void initState() {
    Get.find<ProductController>().getCardProduct();
    Get.find<ProductController>().getCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Obx(
            () => MasonryGridView.count(
              itemCount: Get.find<ProductController>().cardList.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Get.to(() => ProductDetail(
                            product:
                                Get.find<ProductController>().cardList[index],
                            fave: "card",
                          ));
                    },
                    child: Expanded(
                      child: Card(
                        elevation: 10,
                        shadowColor: Color.fromARGB(75, 131, 131, 131),
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: index % 2 == 0 ? 200 : 220,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: FavoriteCard(
                              product: Get.find<ProductController>()
                                  .cardList[index]),
                        ),
                      ),
                    ));
              },
            ),
          ))
        ],
      ),
    );
  }
}
