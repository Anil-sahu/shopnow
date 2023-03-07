import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopnow/modules/widgets/favoriteCard.dart';

import '../../controllers/ProductController.dart';
import '../productDatail/details.dart';
import '../widgets/ProductCard.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    Get.find<ProductController>().getFavoriteProduct();

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
              itemCount: Get.find<ProductController>().favoriteProduct.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Get.to(() => ProductDetail(
                            product: Get.find<ProductController>()
                                .favoriteProduct[index],
                            fave: "Faverite",
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
                                  .favoriteProduct[index]),
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
