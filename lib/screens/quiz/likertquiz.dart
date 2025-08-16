import 'package:flutter/material.dart';

class LikertQuiz extends StatefulWidget {
  final String question;
  final ValueChanged<int> onChanged;
  final int? initialValue;
  final List<String> options;

  const LikertQuiz({
    super.key,
    required this.question,
    required this.onChanged,
    this.initialValue,
    this.options = const [
      'Tidak Pernah',
      'Kadang-kadang',
      'Sering',
      'Sangat Sering',
    ],
  });

  @override
  State<LikertQuiz> createState() => _LikertQuizState();
}

class _LikertQuizState extends State<LikertQuiz> {
  int? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  void didUpdateWidget(LikertQuiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selected = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final isShortScreen = screenHeight < 600;

    // Adaptive font sizes based on screen size
    final instructionFontSize = isSmallScreen ? 14.0 : 16.0;
    final selectedTextFontSize = isSmallScreen ? 14.0 : 16.0;

    // Adaptive padding based on screen size
    final containerPadding = isSmallScreen ? 12.0 : 16.0;
    final optionSpacing = isSmallScreen ? 8.0 : 12.0;
    final sectionSpacing = isShortScreen ? 12.0 : 20.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seberapa sering Anda mengalami hal berikut dalam 1 minggu terakhir?',
            style: TextStyle(
              fontSize: instructionFontSize,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            maxLines: 3,
            overflow: TextOverflow.visible,
          ),
          SizedBox(height: sectionSpacing),

          // Likert Scale Options
          Column(
            children: List.generate(widget.options.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: optionSpacing),
                child: _buildOptionButton(
                  value: index,
                  label: widget.options[index],
                  isSelected: _selected == index,
                  isSmallScreen: isSmallScreen,
                  containerPadding: containerPadding,
                ),
              );
            }),
          ),

          SizedBox(height: sectionSpacing),

          // Selected Answer Indicator
          if (_selected != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(containerPadding),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue[700],
                      size: isSmallScreen ? 18 : 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Anda memilih: ${widget.options[_selected!]}',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600,
                        fontSize: selectedTextFontSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required int value,
    required String label,
    required bool isSelected,
    required bool isSmallScreen,
    required double containerPadding,
  }) {
    // Adaptive sizing
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final checkIconSize = isSmallScreen ? 14.0 : 16.0;
    final labelFontSize = isSmallScreen ? 14.0 : 16.0;
    final valueFontSize = isSmallScreen ? 10.0 : 12.0;
    final selectedLabelFontSize = isSmallScreen ? 10.0 : 12.0;
    final spacingBetween = isSmallScreen ? 12.0 : 16.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = value;
        });
        widget.onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue[300]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue[600]! : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? Colors.blue[600] : Colors.transparent,
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check,
                        size: checkIconSize,
                        color: Colors.white,
                      )
                      : null,
            ),
            SizedBox(width: spacingBetween),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: labelFontSize,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.blue[700] : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Nilai: $value',
                    style: TextStyle(
                      fontSize: valueFontSize,
                      color: isSelected ? Colors.blue[600] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected && !isSmallScreen)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Dipilih',
                  style: TextStyle(
                    fontSize: selectedLabelFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
