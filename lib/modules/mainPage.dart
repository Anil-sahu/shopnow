import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopnow/controllers/ProductController.dart';
import 'package:shopnow/modules/Favorite/FavoritePage.dart';
import 'package:shopnow/modules/home/home_page.dart';
import 'package:shopnow/modules/productDatail/details.dart';
import 'package:shopnow/modules/widgets/CustomeTextFileds.dart';
import 'package:shopnow/modules/widgets/ProductCard.dart';
import 'package:shopnow/modules/widgets/coursoleCard.dart';

import '../models/product/producModel.dart';
import 'AddToCard/MyCard.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _search = TextEditingController();

  var _selectedIndex = 0;
  static const List<Widget> pages = <Widget>[
    HomePage(),
    FavoritePage(),
    MyCard()
  ];

  @override
  void initState() {
    Get.find<ProductController>().getFaverit();
    Get.find<ProductController>().getCard();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  textContainer(double width) {
    return Container(
      height: 12,
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).disabledColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  iconContainer() {
    return Container(
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).disabledColor.withOpacity(0.5),
      ),
    );
  }

  smimmersEffect() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 204,
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Obx(
        () => Shimmer.fromColors(
          baseColor: Theme.of(context).backgroundColor,
          highlightColor: Colors.white,
          enabled: Get.find<ProductController>().isLoading.value,
          child: Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (_, __) => Expanded(
                child: Stack(
                  // crossAxisAlign///////ment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      child: CarouselSlider(
                        items: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 100,
                            color: Colors.white,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopify,
                color: Theme.of(context).selectedRowColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.solidUserCircle,
                color: Theme.of(context).selectedRowColor,
              )),
        ],
      ),
      body: Obx(() => Get.find<ProductController>().isLoading.value
          ? smimmersEffect()
          : pages[_selectedIndex]),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        rippleColor: Colors.white,
        hoverColor: Colors.grey[100]!,
        gap: 5,
        activeColor: Theme.of(context).selectedRowColor,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        tabMargin: EdgeInsets.only(top: 10, bottom: 10),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: const Color.fromARGB(255, 15, 46, 71),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorite',
          ),
          GButton(
            icon: Icons.shopping_cart_sharp,
            text: 'Search',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
