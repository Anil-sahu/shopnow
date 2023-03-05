import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopnow/controllers/ProductController.dart';

class SharePreferenceService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  saveToFavorite(id) async {
    SharedPreferences preferences = await _prefs;
    Get.find<ProductController>().getFaverit();
    Get.find<ProductController>().addToFavorite(id);
    preferences.setStringList(
        "favorite", Get.find<ProductController>().favoriteList);
  }

  Future<List<String>?> getSaveFavorite() async {
    SharedPreferences preferences = await _prefs;
    return preferences.getStringList("favorite");
  }

  saveToCard(id) async {
    SharedPreferences preferences = await _prefs;
    Get.find<ProductController>().getCard();
    Get.find<ProductController>().addToCard(id);
    preferences.setStringList(
        "card", Get.find<ProductController>().addToCardList);
  }

  Future<List<String>?> getSaveCard() async {
    SharedPreferences preferences = await _prefs;
    return preferences.getStringList("favorite");
  }
}
