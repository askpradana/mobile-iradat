import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../presentation/views/base_view.dart';
import '../controllers/onboarding_controller.dart';
import '../../domain/entities/onboarding_item.dart';

class OnboardingView extends BaseView<OnboardingController> {
  const OnboardingView({super.key});
  
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(controller.items[index]);
            },
          ),
        ),
        _buildBottomSection(),
      ],
    );
  }
  
  Widget _buildOnboardingPage(OnboardingItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 60,
              color: item.color,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            item.title,
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.subtitle,
            style: Get.textTheme.titleMedium?.copyWith(
              color: item.color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              item.description,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildPageIndicator(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkipButton(),
              _buildNextButton(),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPageIndicator() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.items.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: controller.currentPage.value == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: controller.currentPage.value == index
                ? Get.theme.colorScheme.primary
                : Get.theme.colorScheme.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ));
  }
  
  Widget _buildSkipButton() {
    return TextButton(
      onPressed: controller.skipOnboarding,
      child: Text(
        'Skip',
        style: TextStyle(
          color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  Widget _buildNextButton() {
    return Obx(() => ElevatedButton(
      onPressed: controller.nextPage,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.currentPage.value == controller.items.length - 1
                ? 'Get Started'
                : 'Next',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 18),
        ],
      ),
    ));
  }
}