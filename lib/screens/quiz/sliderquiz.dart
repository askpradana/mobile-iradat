import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// SliderQuiz widget for 0-10 scale questions with custom SyncFunction style.
///
/// [question] is the question text to display.
/// [onChanged] is called with the selected value when the user interacts.
/// [initialValue] is the starting value for the slider (default 0).
class SliderQuiz extends StatefulWidget {
  final String question;
  final ValueChanged<double> onChanged;
  final double initialValue;

  const SliderQuiz({
    super.key,
    required this.question,
    required this.onChanged,
    this.initialValue = 0,
  });

  @override
  State<SliderQuiz> createState() => _SliderQuizState();
}

class _SliderQuizState extends State<SliderQuiz> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackHeight: 8,
            inactiveTrackHeight: 8,
            thumbRadius: 16,
            thumbColor: Colors.green[600],
            activeTrackColor: Colors.green[400],
            inactiveTrackColor: Colors.red[200],
            overlayColor: Colors.green.withOpacity(0.12),
            tooltipBackgroundColor: Colors.green[600],
          ),
          child: SfSlider(
            min: 0.0,
            max: 10.0,
            value: _value,
            interval: 1,
            showTicks: true,
            showLabels: false,
            enableTooltip: true,
            stepSize: 1,
            onChanged: (dynamic value) {
              setState(() {
                _value = value;
              });
              widget.onChanged(value);
            },
            trackShape: _SyncFunctionTrackShape(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('0', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text('10', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'Sangat Tidak Setuju',
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                'Sangat Setuju',
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Text(
            'Current Value: ${_value.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
        ),
      ],
    );
  }
}

class _SyncFunctionTrackShape extends SfTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset,
    Offset? thumbCenter,
    Offset? startThumbCenter,
    Offset? endThumbCenter, {
    required RenderBox parentBox,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Animation<double> enableAnimation,
    required Paint? inactivePaint,
    required Paint? activePaint,
    required TextDirection textDirection,
  }) {
    if (thumbCenter == null) return;
    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      offset.dy - themeData.activeTrackHeight / 2,
      parentBox.size.width,
      themeData.activeTrackHeight,
    );
    // Draw active track (left of thumb)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          thumbCenter.dx,
          trackRect.bottom,
        ),
        Radius.circular(4),
      ),
      activePaint ?? Paint()
        ..color = themeData.activeTrackColor ?? Colors.green,
    );
    // Draw inactive track (right of thumb)
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          thumbCenter.dx,
          trackRect.top,
          trackRect.right,
          trackRect.bottom,
        ),
        Radius.circular(4),
      ),
      inactivePaint ?? Paint()
        ..color = themeData.inactiveTrackColor ?? Colors.red,
    );
  }
}
