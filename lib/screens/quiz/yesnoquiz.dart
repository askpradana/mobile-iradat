import 'package:flutter/material.dart';

/// YesNoQuiz widget for yes/no questions.
///
/// [question] is the question text to display.
/// [onChanged] is called with the selected answer (true for Yes, false for No).
/// [initialValue] is the starting value for the answer (null, true, or false).
class YesNoQuiz extends StatefulWidget {
  final String question;
  final ValueChanged<bool> onChanged;
  final bool? initialValue;

  const YesNoQuiz({
    super.key,
    required this.question,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<YesNoQuiz> createState() => _YesNoQuizState();
}

class _YesNoQuizState extends State<YesNoQuiz> {
  bool? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  // This is the key addition to fix the state management issue
  @override
  void didUpdateWidget(YesNoQuiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the selected answer when initialValue changes
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selected = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnswerButton(
                answer: true,
                label: 'YES',
                icon: Icons.check_circle,
                color: Colors.green,
                isSelected: _selected == true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildAnswerButton(
                answer: false,
                label: 'NO',
                icon: Icons.cancel,
                color: Colors.red,
                isSelected: _selected == false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_selected != null)
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    _selected!
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      _selected!
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                _selected! ? 'You selected YES' : 'You selected NO',
                style: TextStyle(
                  color: _selected! ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAnswerButton({
    required bool answer,
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = answer;
        });
        widget.onChanged(answer);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.2) : Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
