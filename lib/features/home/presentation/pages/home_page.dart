import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/core/utils/notification_service.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.bottomNavbarTitles[controller.currentIndex.value],
          ),
          automaticallyImplyLeading: false,
        ),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [_buildHomeTab(controller), _buildSettingsTab(controller)],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(HomeController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Quiz Iradat',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Your mental health assessment companion',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          _buildQuickActions(controller),
          const SizedBox(height: 32),
          _buildAssessmentCards(controller),
        ],
      ),
    );
  }

  Widget _buildQuickActions(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.quiz_outlined,
                title: 'Take Assessment',
                subtitle: 'Start a new quiz',
                onTap: controller.navigateToQuizzes,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                icon: Icons.person_outlined,
                title: 'Profile',
                subtitle: 'Manage account',
                onTap: controller.navigateToProfile,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Get.theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssessmentCards(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Assessments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildAssessmentCard(
          'DASS-21',
          'Depression, Anxiety and Stress Scale',
          'Assess your current mental health state',
          Colors.blue,
          controller.navigateToQuizzes,
        ),
        const SizedBox(height: 12),
        _buildAssessmentCard(
          'SRQ-20',
          'Self-Reporting Questionnaire',
          'Screen for common mental disorders',
          Colors.green,
          controller.navigateToQuizzes,
        ),
        const SizedBox(height: 12),
        _buildAssessmentCard(
          'SMFA-10',
          'Short Form Mental Fitness Assessment',
          'Quick mental fitness evaluation',
          Colors.orange,
          controller.navigateToQuizzes,
        ),
      ],
    );
  }

  Widget _buildAssessmentCard(
    String title,
    String subtitle,
    String description,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.psychology_outlined, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTab(HomeController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildSettingsCard(
            icon: Icons.person_outlined,
            title: 'Profile',
            subtitle: 'Manage your account information',
            onTap: controller.navigateToProfile,
          ),
          const SizedBox(height: 12),
          _buildSettingsCard(
            icon: Icons.info_outlined,
            title: 'About',
            subtitle: 'Learn more about Quiz Iradat',
            onTap:
                () => NotificationService.showInfo(
                  'Coming Soon',
                  'About page coming soon',
                ),
          ),
          const SizedBox(height: 12),
          _buildSettingsCard(
            icon: Icons.help_outline,
            title: 'FAQ',
            subtitle: 'Frequently asked questions',
            onTap:
                () => NotificationService.showInfo(
                  'Coming Soon',
                  'FAQ page coming soon',
                ),
          ),
          const SizedBox(height: 12),
          _buildSettingsCard(
            icon: Icons.contact_support_outlined,
            title: 'Contact Us',
            subtitle: 'Get help and support',
            onTap:
                () => NotificationService.showInfo(
                  'Coming Soon',
                  'Contact page coming soon',
                ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Get.theme.colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
