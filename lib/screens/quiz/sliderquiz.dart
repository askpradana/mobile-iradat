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
  void didUpdateWidget(SliderQuiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the slider value when initialValue changes
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _value = widget.initialValue;
      });
    }
  }

  // Option 1: Blue gradient to match your app theme
  Color _getSliderColorBlue(double value) {
    double t = value / 10.0;
    return Color.lerp(
      const Color(0xFFE3F2FD), // Very light blue (matches your app)
      const Color(0xFF1976D2), // Deep blue (matches your progress bar)
      t,
    )!;
  }

  // Option 2: Keep gray but make it warmer to match better
  Color _getSliderColorWarmGray(double value) {
    double t = value / 10.0;
    return Color.lerp(
      const Color(0xFFF5F5F5), // Warmer light gray
      const Color(0xFF424242), // Softer dark gray
      t,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final Color dynamicColor = _getSliderColorBlue(
      _value,
    ); // Change this to try different options

    return Column(
      children: [
        SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackHeight: 8,
            inactiveTrackHeight: 8,
            thumbRadius: 16,
            thumbColor: dynamicColor,
            activeTrackColor: dynamicColor,
            inactiveTrackColor: Colors.grey[200], // Lighter inactive track
            overlayColor: dynamicColor.withValues(alpha: .12),
            tooltipBackgroundColor: dynamicColor,
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
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'Sangat Tidak Setuju',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ), // Changed from red to neutral
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                'Sangat Setuju',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ), // Changed from green to neutral
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: dynamicColor.withValues(
              alpha: 0.1,
            ), // Use dynamic color with low opacity
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: dynamicColor.withValues(alpha: 0.3),
            ), // Dynamic border
          ),
          child: Text(
            'Current Value: ${_value.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: dynamicColor, // Dynamic text color
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
        ..color = themeData.activeTrackColor ?? Colors.blue,
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
        ..color = themeData.inactiveTrackColor ?? Colors.grey[200]!,
    );
  }
}
