import '../entities/base_entity.dart';

abstract class Question extends BaseEntity {
  final int questionNumber;
  final String questionContent;
  
  const Question({
    required this.questionNumber,
    required this.questionContent,
  });
  
  @override
  List<Object?> get props => [questionNumber, questionContent];
}

class YesNoQuestion extends Question {
  const YesNoQuestion({
    required super.questionNumber,
    required super.questionContent,
  });
}

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final String? minLabel;
  final String? maxLabel;
  
  const SliderQuestion({
    required super.questionNumber,
    required super.questionContent,
    this.minValue = 0,
    this.maxValue = 10,
    this.minLabel,
    this.maxLabel,
  });
  
  @override
  List<Object?> get props => [
    questionNumber,
    questionContent,
    minValue,
    maxValue,
    minLabel,
    maxLabel,
  ];
}