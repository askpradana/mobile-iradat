import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildLoadingWidget();
        }
        
        if (controller.error.value != null) {
          return buildErrorWidget(controller.error.value!);
        }
        
        return buildBody(context);
      }),
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
  
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;
  
  Widget buildBody(BuildContext context);
  
  Widget? buildFloatingActionButton(BuildContext context) => null;
  
  Widget? buildBottomNavigationBar(BuildContext context) => null;
  
  Widget buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  
  Widget buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Get.theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Get.textTheme.headlineMedium?.copyWith(
              color: Get.theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.clearError(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}