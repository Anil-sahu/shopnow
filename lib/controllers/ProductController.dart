import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopnow/localstorage/sharePreferences.dart';
import 'package:shopnow/services/remote_service.dart';

class ProductController extends GetxController {
  var allProduct = [].obs;

  var category = [].obs;

  var getCategoryProduct = [].obs;
  var productSearchList = [].obs;
  var addToCardList = <String>[].obs;
  var cardList = [].obs;
  var favoriteList = <String>[].obs;
  var favoriteProduct = [].obs;
  var totalPayAbleAmount = 0.obs;

  var isLoading = false.obs;
  var isSearch = false.obs;
  var isFilter = false.obs;

  final SharePreferenceService _sharePreferenceService =
      SharePreferenceService();

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  filter() {
    isFilter.value = !isFilter.value;
    stopSearch();
  }

  startSearch() {
    isSearch.value = true;
    isFilter.value = false;
  }

  stopSearch() {
    isSearch.value = false;
  }

  loadingStart() {
    isLoading.value = true;
  }

  loadingStop() {
    isLoading.value = false;
  }

  addAmount(int amount) {
    totalPayAbleAmount.value += amount;
  }

  removeAmount(int amount) {
    totalPayAbleAmount.value -= amount;
  }

  payAbleAmount() {
    totalPayAbleAmount.value = 0;
    for (var i = 0; i < Get.find<ProductController>().cardList.length; i++) {
      addAmount(int.parse(
          Get.find<ProductController>().cardList[i]['price'].toString()));
    }
  }

  List get products {
    if (isSearch.value) {
      return [...productSearchList.value];
    }
    if (isFilter.value) {
      return [...getCategoryProduct];
    }
    return [...allProduct];
  }

  getProduct() {}

  addToFavorite(id) async {
    if (favoriteList.contains(id.toString())) {
      favoriteList.remove(id.toString());
    } else {
      favoriteList.add(id.toString());
    }
    getFaverit();
  }

  getFaverit() async {
    favoriteList.value = (await _sharePreferenceService.getSaveFavorite())!;
  }

  addToCard(id) {
    if (addToCardList.contains(id.toString())) {
      addToCardList.remove(id.toString());
    } else {
      addToCardList.add(id.toString());
    }
    getCard();
  }

  getCard() async {
    addToCardList.value = (await _sharePreferenceService.getSaveCard())!;
  }

  void fetchProduct() async {
    loadingStart();
    var pro = await RemoteService.fetchProduct().whenComplete(() {
      loadingStop();
    });

    if (pro != null) {
      allProduct.value = pro.products;
    } else {}
  }

  void fetchGategory() async {
    loadingStart();
    var cat = await RemoteService.getProductCategory();
    loadingStop();
    if (cat != null) {
      category.value = cat;
    }
  }

  void searchProducts(search) async {
    loadingStart();
    var pro = await RemoteService.searchProduct(search);
    loadingStop();
    if (pro != null) {
      productSearchList.value = pro.products;
    }
  }

  getProductBycate(cate) async {
    // getCategoryProduct.value = [];
    try {
      loadingStart();
      var pro = await RemoteService.getProductByCategory(cate);
      loadingStop();
      if (pro != null) getCategoryProduct.value = pro.products;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getFavoriteProduct() async {
    favoriteProduct.clear();
    for (var i = 0; i < favoriteList.length; i++) {
      var pro = await RemoteService.getProduct(favoriteList[i]);

      if (pro != null) {
        favoriteProduct.add(pro);
      }
    }
  }

  getCardProduct() async {
    cardList.clear();
    for (var i = 0; i < addToCardList.length; i++) {
      var pro = await RemoteService.getProduct(addToCardList[i]);
      if (pro != null) {
        cardList.add(pro);
      }
    }
  }
}
