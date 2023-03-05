import 'package:get/get.dart';
import 'package:shopnow/controllers/ProductController.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController());
  }
}
