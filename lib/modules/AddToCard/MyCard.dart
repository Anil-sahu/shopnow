import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopnow/modules/buyProduct/BuyProduct.dart';

import '../../controllers/ProductController.dart';
import '../../localstorage/sharePreferences.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  SharePreferenceService sps = SharePreferenceService();
  var totalPayableAmount = 0;

  @override
  void initState() {
    // payAbleAmount();
    Get.find<ProductController>().payAbleAmount();
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
              () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: Get.find<ProductController>().cardList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              Get.find<ProductController>().cardList[index]
                                  ['thumbnail'],
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: [
                                  Text(Get.find<ProductController>()
                                      .cardList[index]['title']),
                                  Text(
                                    "\$ ${Get.find<ProductController>().cardList[index]['price'].toString()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.find<ProductController>().removeAmount(
                                    int.parse(Get.find<ProductController>()
                                        .cardList[index]['price']
                                        .toString()));
                                sps.saveToCard(Get.find<ProductController>()
                                    .cardList[index]['id']);
                                setState(() {
                                  totalPayableAmount -= int.parse(
                                      Get.find<ProductController>()
                                          .cardList[index]['price']
                                          .toString());
                                });
                              },
                              icon: const Icon(Icons.cancel),
                            )
                          ]),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
              heroTag: "payAbleAmount",
              backgroundColor: const Color.fromARGB(255, 15, 46, 71),
              onPressed: () {},
              label: Obx(() {
                return Text(
                    "\$ ${Get.find<ProductController>().totalPayAbleAmount}");
              })),
          FloatingActionButton.extended(
              heroTag: "checkout",
              backgroundColor: const Color.fromARGB(255, 15, 46, 71),
              onPressed: () {
                Get.to(() => BuyProduct());
              },
              label: const Text("Check out")),
        ],
      ),
    );
  }
}
