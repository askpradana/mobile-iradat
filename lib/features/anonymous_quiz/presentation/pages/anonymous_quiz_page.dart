import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anonymous_quiz_controller.dart';
import '../widgets/quiz_question_widget.dart';

class AnonymousQuizPage extends StatelessWidget {
  const AnonymousQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnonymousQuizController>();

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(controller.quizData.value?.title ?? 'Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _showBackConfirmationDialog(context, controller),
        ),
        actions: [
          _buildTimerWidget(controller),
          const SizedBox(width: 8),
        ],
      ),
      body: controller.questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Progress indicator
                _buildProgressIndicator(controller),
                
                // Question content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Current question
                        QuizQuestionWidget(
                          question: controller.questions[controller.currentQuestionIndex.value],
                          selectedAnswer: controller.answers[controller.questions[controller.currentQuestionIndex.value].questionNumber],
                          onAnswerSelected: (answer) {
                            controller.selectAnswer(
                              controller.questions[controller.currentQuestionIndex.value].questionNumber,
                              answer,
                            );
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ),
                
                // Bottom navigation
                _buildBottomNavigation(controller),
              ],
            ),
    ));
  }

  Widget _buildTimerWidget(AnonymousQuizController controller) {
    return Obx(() => Text(
      _formatTime(controller.elapsedTime.value),
      style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
        color: Theme.of(Get.context!).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    ));
  }

  Widget _buildProgressIndicator(AnonymousQuizController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Clean progress text
          Text(
            '${controller.progressPercentage}% Complete',
            style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Minimal progress bar
          LinearProgressIndicator(
            value: (controller.currentQuestionIndex.value + 1) / controller.totalQuestions,
            backgroundColor: Theme.of(Get.context!).colorScheme.outline.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(Get.context!).colorScheme.primary,
            ),
            minHeight: 4,
          ),
        ],
      ),
    );
  }


  Widget _buildBottomNavigation(AnonymousQuizController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        child: controller.isLastQuestion
            ? _buildSubmitButton(controller)
            : _buildNextButton(controller),
      ),
    );
  }

  Widget _buildNextButton(AnonymousQuizController controller) {
    return ElevatedButton.icon(
      onPressed: controller.hasAnsweredCurrentQuestion() 
          ? controller.nextQuestion 
          : null,
      icon: const Icon(Icons.arrow_forward),
      label: const Text('Next'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(AnonymousQuizController controller) {
    return Obx(() => ElevatedButton.icon(
      onPressed: controller.allQuestionsAnswered && !controller.isSubmitting.value
          ? () => _showSubmitConfirmationDialog(Get.context!, controller)
          : null,
      icon: controller.isSubmitting.value
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.check),
      label: Text(controller.isSubmitting.value ? 'Submitting...' : 'Submit Quiz'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        foregroundColor: Theme.of(Get.context!).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ));
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showBackConfirmationDialog(BuildContext context, AnonymousQuizController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Leave Quiz?'),
          content: const Text(
            'Are you sure you want to leave the quiz? Your progress will be lost.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.backToForm();
              },
              child: const Text('Leave'),
            ),
          ],
        );
      },
    );
  }

  void _showSubmitConfirmationDialog(BuildContext context, AnonymousQuizController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit Quiz?'),
          content: Text(
            'You have answered ${controller.totalAnswered} out of ${controller.totalQuestions} questions. '
            'Are you ready to submit your responses?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Review'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.submitQuiz();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}