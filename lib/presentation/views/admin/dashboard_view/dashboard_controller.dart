import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/data/repositories/product_repositories.dart';
import 'package:simple_e_commerce/core/enums/file_type.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';
import 'package:simple_e_commerce/presentation/views/admin/all_products_view_admin/all_products_view_controller.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_show_snackbar.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_toast.dart';

class DashboardController extends BaseController {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey(debugLabel: 'AddItem');
  String? categoryController;
  late File imageFile;
  int totalRevenue = 0;
  int totalProducts = 0;
  int totalOrders = 0;
  List<ProductEntity> productsMine = <ProductEntity>[];
  late UserModel userInfo;
  final ImagePicker picker = ImagePicker();
  String imageRecipe = '';

  void setUserInfo(UserModel user) {
    userInfo = user;
  }

  initFieldAddProduct() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    categoryController = null;
    stockQuantityController.clear();
    imageRecipe = '';
  }

  Future getALlProductsMine() async {
    productsMine.clear();
    totalOrders = 0;
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.getProductsMine().then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              productsMine.addAll(r);
              totalProducts = productsMine.length;
              update();
            },
          );
        });
      },
    );
  }

  addProduct() async {
    AllProductsViewController allProductsViewController = Get.find();
    ProductModel product = ProductModel();
    // product.images = [imageRecipe];
    product.images = ['https://example.com/framework-laptop.jpg'];
    product.title = titleController.text;
    product.description = descriptionController.text;
    product.price = double.parse(priceController.text);
    product.stockQuantity = int.parse(stockQuantityController.text);
    product.categoryId =
        allProductsViewController.allCategory.firstWhere((category) {
          return category.name == categoryController;
        }).id;
    product.rating = Rating(count: 23, rate: 3.2);
    Map<String, dynamic> productJson = product.toJson();
    print(productJson);
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.createProduct(
          product: productJson,
          image: imageFile,
        ).then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
              update();
            },
            (r) async {
              print(r);
              await getALlProductsMine();
              Get.back();
              showSnackBar(title: 'Item added successfully');
              update();
            },
          );
        });
      },
    );
  }

  Future searchProducts({required String title}) async {
    productsMine.clear();
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.searchProduct(title: title).then((value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) {
              productsMine.addAll(r);
              update();
            },
          );
        });
      },
    );
  }

  Future deleteProduct({required ProductEntity product}) async {
    productsMine.clear();
    await runLoadingFutureFunction(
      function: () async {
        await ProductRepositories.deleteProduct(productId: product.id).then((
          value,
        ) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessageType.REJECTED,
              );
            },
            (r) async {
              Get.back();
              await getALlProductsMine();
              update();
            },
          );
        });
      },
    );
  }

  Future pickImage(FileTypeEnum type) async {
    String imageUpload = '';
    XFile? image;
    switch (type) {
      case FileTypeEnum.camera:
        image = await picker.pickImage(source: ImageSource.camera);
        image != null ? imageUpload = image.path : null;
        break;
      case FileTypeEnum.gallery:
        image = await picker.pickImage(source: ImageSource.gallery);
        image != null ? imageUpload = image.path : null;
        break;
      case FileTypeEnum.file:
        Get.closeAllSnackbars();
        showSnackBar(title: 'Please upload image not file');
        break;
    }
    if (imageUpload != '') {
      imageFile = File(image!.path);
      return imageRecipe = imageUpload;
    } else {
      showSnackBar(title: 'Please upload a valid image');
    }
  }

  @override
  void onInit() async {
    await getALlProductsMine();
    super.onInit();
  }
}
