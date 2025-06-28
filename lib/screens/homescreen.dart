import 'package:flutter/material.dart';
import 'package:quiz_iradat/screens/quizdescriptionscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/screens/loginscreen.dart';
import 'package:quiz_iradat/settings/supabase.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> _quizzes = [];

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/quizzes.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      setState(() {
        _quizzes = List<Map<String, dynamic>>.from(jsonData['quizzes']);
      });
    } catch (e) {
      debugPrint('Error loading quizzes: $e');
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      return;
    }

    try {
      await http.post(
        Uri.parse('$supabaseUrl/auth/v1/logout'),
        headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseAPIKey,
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      // Even if logout fails, clear local token and navigate
      // to allow re-authentication.
      debugPrint('Logout API call failed: $e');
    } finally {
      // Always clear local token and navigate
      await prefs.remove('auth_token');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  Widget _buildHomeScreen() {
    return _quizzes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _quizzes.length,
            itemBuilder: (context, index) {
              final quiz = _quizzes[index];
              final quizId = quiz['id'] as String;
              final isAvailable = quiz['isAvailable'] as bool;
              final totalQuestions = quiz['questions'] as int;
              final timeLimit = quiz['timeLimit'] as int;
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
                        isAvailable
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => QuizScreen(
                                        quizTitle: quiz['title'] as String,
                                        quizId: quizId,
                                        totalQuestions: totalQuestions,
                                        timeLimit: timeLimit,
                                        quizDescription:
                                            quiz['description'] as String,
                                      ),
                                ),
                              );
                            }
                            : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quiz['title'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isAvailable
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
                                        isAvailable
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
                                  isAvailable
                                      ? Colors.green[50]
                                      : Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isAvailable
                                        ? Colors.green[200]!
                                        : Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              isAvailable ? 'Available' : 'Locked',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    isAvailable
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
        );
  }

  Widget _buildProfileScreen() {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit Profile tapped')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Application Settings'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Application Settings tapped')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About Application'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('About Application tapped')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Frequently Asked Questions'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Frequently Asked Questions tapped'),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail_outlined),
          title: const Text('Contact Us'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Contact Us tapped')));
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy Policy tapped')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () => _handleLogout(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [_buildHomeScreen(), _buildProfileScreen()];

    final List<String> titles = ['Quizzes', 'Profile'];

    return Scaffold(
      appBar: AppBar(title: Text(titles[_currentIndex])),
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
