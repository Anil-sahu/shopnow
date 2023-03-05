import 'package:get/get.dart';
import 'package:shopnow/localstorage/sharePreferences.dart';
import 'package:shopnow/services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var allProduct = [].obs;

  var category = [].obs;

  var getCategoryProduct = [].obs;
  var productSearchList = [].obs;
  var addToCardList = <String>[].obs;
  var cardList = [].obs;
  var favoriteList = <String>[].obs;
  var favoriteProduct = [].obs;
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
    isSearch.value = false;
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
    } else {
      print("no product available");
    }
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
      productSearchList.value = pro;
    }
  }

  getProductBycate(cate) async {
    getCategoryProduct.value = [];
    try {
      loadingStart();
      var pro = await RemoteService.getProductByCategory(cate);
      loadingStop();

      getCategoryProduct.value = pro;
    } catch (e) {}
  }

  getFavoriteProduct() async {
    favoriteProduct.clear();
    for (var i = 0; i < favoriteList.length; i++) {
      print(int.parse(favoriteList[i]));
      var pro = await RemoteService.getProduct(favoriteList[i]);
      print("Favro--------------");
      print(pro);
      if (pro != null) {
        favoriteProduct.add(pro);
      }
    }
  }

  getCardProduct() async {
    favoriteProduct.clear();
    for (var i = 0; i < addToCardList.length; i++) {
      print(int.parse(favoriteList[i]));
      var pro = await RemoteService.getProduct(addToCardList[i]);
      print("Favro--------------");
      print(pro);
      if (pro != null) {
        cardList.add(pro);
      }
    }
    // getProductCategory() async {
    //   var url = "https://dummyjson.com/products/categories";
    //   try {
    //     var response = await http.Client()
    //         .get(Uri.parse(url))
    //         .whenComplete(() => print("complete"));
    //     var decode = jsonDecode(response.body);
    //     print(decode);
    //   } catch (e) {}
    // }
  }
}
