import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/quiz_model.dart';
import '../models/question_model.dart';
import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';

abstract class QuizLocalDataSource {
  Future<List<QuizModel>> getAllQuizzes();
  Future<List<QuestionModel>> getQuizQuestions(String quizId);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  @override
  Future<List<QuizModel>> getAllQuizzes() async {
    try {
      final jsonString = await rootBundle.loadString(AppConstants.quizzesJsonPath);
      final jsonData = json.decode(jsonString);
      final quizListModel = QuizListModel.fromJson(jsonData);
      return quizListModel.quizzes;
    } catch (e) {
      throw CacheException('Failed to load quizzes: $e');
    }
  }
  
  @override
  Future<List<QuestionModel>> getQuizQuestions(String quizId) async {
    try {
      String filePath;
      bool isSliderType = false;
      
      switch (quizId) {
        case 'self-reporting-questionnaire-20':
          filePath = AppConstants.srq20JsonPath;
          break;
        case 'stress-management-self-assessment':
          filePath = AppConstants.smfa10JsonPath;
          isSliderType = true;
          break;
        default:
          throw CacheException('Quiz not found: $quizId');
      }
      
      final jsonString = await rootBundle.loadString(filePath);
      final jsonData = json.decode(jsonString);
      final questionListModel = QuestionListModel.fromJson(jsonData, isSlider: isSliderType);
      return questionListModel.questions;
    } catch (e) {
      throw CacheException('Failed to load quiz questions: $e');
    }
  }
}