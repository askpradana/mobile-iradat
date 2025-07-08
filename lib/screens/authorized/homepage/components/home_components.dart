import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_controller.dart';
import 'package:quiz_iradat/screens/quizdescriptionscreen.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.isQuizEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: controller.quizzes.length,
                  itemBuilder: (_, i) {
                    final quiz = controller.quizzes[i];
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
                              controller.isQuizAvailableByIndex(i)
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
                                              controller.isQuizAvailableByIndex(
                                                    i,
                                                  )
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
                                              controller.isQuizAvailableByIndex(
                                                    i,
                                                  )
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
                                        controller.isQuizAvailableByIndex(i)
                                            ? Colors.green[50]
                                            : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          controller.isQuizAvailableByIndex(i)
                                              ? Colors.green[200]!
                                              : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    controller.isQuizAvailableByIndex(i)
                                        ? 'Available'
                                        : 'Locked',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          controller.isQuizAvailableByIndex(i)
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
}
