import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LikertScaleWidget extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final List<String> labels;
  final bool enabled;

  const LikertScaleWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.labels = const ['Never', 'Sometimes', 'Often', 'Almost Always'],
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        // Slider
        SfSlider(
          min: 0.0,
          max: 3.0,
          value: value.toDouble(),
          interval: 1.0,
          stepSize: 1.0,
          showTicks: true,
          showLabels: false,
          enableTooltip: false,
          onChanged: enabled ? (dynamic newValue) {
            onChanged(newValue.toInt());
          } : null,
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.outline.withValues(alpha: 0.3),
          thumbIcon: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.surface,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(labels.length, (index) {
            final isSelected = value == index;
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    // Score indicator
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? colorScheme.primary
                            : colorScheme.outline.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            color: isSelected 
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Label text - optimized for Indonesian
                    Text(
                      labels[index],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected 
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.7),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 11,
                        height: 1.3,
                        letterSpacing: 0.15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        
      ],
    );
  }
}