import 'package:flutter/material.dart';
import '../../../../domain/entities/base_entity.dart';

class OnboardingItem extends BaseEntity {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });
  
  @override
  List<Object?> get props => [title, subtitle, description, icon, color];
}