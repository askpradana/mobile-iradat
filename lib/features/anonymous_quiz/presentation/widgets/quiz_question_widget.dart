import 'package:flutter/material.dart';
import '../../models.dart';
import 'likert_scale_widget.dart';

class QuizQuestionWidget extends StatelessWidget {
  final QuizQuestion question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;
  final bool isEnabled;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    this.selectedAnswer,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question content
          Text(
            question.questionContent,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: 0.15,
            ),
          ),

          const SizedBox(height: 24),

          // Instructions
          Text(
            'Pilih skala dari 4 opsi di bawah ini yang paling sesuai dengan perasaan Anda dalam 1 minggu terakhir.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 24),

          // Likert scale
          LikertScaleWidget(
            value: selectedAnswer ?? 0,
            onChanged: onAnswerSelected,
            enabled: isEnabled,
            labels: const [
              'Tidak Pernah Terjadi Pada Saya',
              'Kadang Terjadi Pada Saya',
              'Sering Terjadi Pada Saya',
              'Hampir Selalu Terjadi Pada Saya',
            ],
          ),
        ],
      ),
    );
  }
}
