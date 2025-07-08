import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_controller.dart';
import 'package:quiz_iradat/screens/quizdescriptionscreen.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final c = Get.put(HomeController());
    final c = Get.find<HomeController>();

    final List<String> titles = ['Quizzes', 'Profile'];

    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text(titles[c.currentIndex.value])),
        body: IndexedStack(
          index: c.currentIndex.value,
          children: [_buildHomeScreen(c), _buildProfileScreen(context, c)],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            currentIndex: c.currentIndex.value,
            onTap: (i) => c.currentIndex.value = i,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScreen(HomeController c) {
    return Obx(
      () =>
          c.isQuizEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: c.quizzes.length,
                  itemBuilder: (_, i) {
                    final quiz = c.quizzes[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 0,
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap:
                              c.isQuizAvailableByIndex(i)
                                  ? () {
                                    Get.to(
                                      () => QuizScreen(
                                        quizTitle: quiz['title'],
                                        quizId: quiz['id'],
                                        totalQuestions: quiz['questions'],
                                        timeLimit: quiz['timeLimit'],
                                        quizDescription: quiz['description'],
                                        quizType: quiz['quizType'],
                                      ),
                                    );
                                  }
                                  : null,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        quiz['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              c.isQuizAvailableByIndex(i)
                                                  ? Colors.black87
                                                  : Colors.grey[500],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${quiz['questions']} Questions',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              c.isQuizAvailableByIndex(i)
                                                  ? Colors.grey[600]
                                                  : Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        c.isQuizAvailableByIndex(i)
                                            ? Colors.green[50]
                                            : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          c.isQuizAvailableByIndex(i)
                                              ? Colors.green[200]!
                                              : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    c.isQuizAvailableByIndex(i)
                                        ? 'Available'
                                        : 'Locked',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          c.isQuizAvailableByIndex(i)
                                              ? Colors.green[700]
                                              : Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }

  Widget _buildProfileScreen(BuildContext context, HomeController c) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _snack(context, 'Edit Profile tapped'),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Application Settings'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed('/settings'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About Application'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _snack(context, 'About Application tapped'),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Frequently Asked Questions'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _snack(context, 'FAQ tapped'),
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail_outlined),
          title: const Text('Contact Us'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _snack(context, 'Contact Us tapped'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _snack(context, 'Privacy Policy tapped'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () => c.handleLogout(context),
        ),
      ],
    );
  }

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
