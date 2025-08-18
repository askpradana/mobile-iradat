import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/anonymous_repository.dart';
import '../../models.dart';

class AnonymousQuizController extends GetxController {
  final AnonymousRepository repo;

  AnonymousQuizController(this.repo);

  // Loading states
  final isLoading = false.obs;
  final isValidating = false.obs;
  final isRegistering = false.obs;
  final isSubmitting = false.obs;

  
  // Form controllers
  final codeFormKey = GlobalKey<FormState>();
  final userFormKey = GlobalKey<FormState>();
  final referralCodeController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final organizationController = TextEditingController();

  // Quiz state
  final Rxn<QuizData> quizData = Rxn<QuizData>();
  final RxList<QuizQuestion> questions = <QuizQuestion>[].obs;
  final RxMap<int, int> answers = <int, int>{}.obs;
  final currentQuestionIndex = 0.obs;
  
  // Quiz timing
  late DateTime quizStartTime;
  Timer? quizTimer;
  final elapsedTime = 0.obs;

  // Token and session
  final Rxn<String> anonymousToken = Rxn<String>();
  final Rxn<QuizSubmissionData> submissionResult = Rxn<QuizSubmissionData>();

  @override
  void onInit() {
    super.onInit();
    resetFlow();
  }

  void resetFlow() {
    isLoading.value = false;
    isValidating.value = false;
    isRegistering.value = false;
    isSubmitting.value = false;
    
    // Clear form controllers
    referralCodeController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    organizationController.clear();
    
    // Clear quiz data
    quizData.value = null;
    questions.clear();
    answers.clear();
    currentQuestionIndex.value = 0;
    elapsedTime.value = 0;
    anonymousToken.value = null;
    submissionResult.value = null;

    // Clear quiz timer
    quizTimer?.cancel();
    quizTimer = null;
  }

  // Step 1: Validate referral code
  Future<void> validateReferralCode() async {
    if (!codeFormKey.currentState!.validate()) return;
    if (isValidating.value) return;

    isValidating.value = true;
    final result = await repo.validateReferralCode(referralCodeController.text.trim());
    isValidating.value = false;

    if (result != null && result.success) {
      Get.toNamed('/anonymous-form');
    }
  }

  // Step 2: Register anonymous user
  Future<void> registerAnonymousUser() async {
    if (!userFormKey.currentState!.validate()) return;
    if (isRegistering.value) return;

    isRegistering.value = true;
    
    final request = AnonymousRegistrationRequest(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      organization: organizationController.text.trim(),
    );

    final result = await repo.registerAnonymous(
      referralCodeController.text.trim(), 
      request
    );
    
    isRegistering.value = false;

    if (result != null && result.success) {
      // Store quiz data and questions
      quizData.value = result.data.quiz;
      questions.value = result.data.questions;
      anonymousToken.value = result.data.token;
      
      // Initialize quiz timing
      quizStartTime = DateTime.now();
      _startQuizTimer();
      
      Get.toNamed('/anonymous-quiz');
    }
  }

  // Quiz functionality
  void _startQuizTimer() {
    quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value = DateTime.now().difference(quizStartTime).inSeconds;
    });
  }

  void selectAnswer(int questionNumber, int answer) {
    answers[questionNumber] = answer;
  }

  bool hasAnsweredCurrentQuestion() {
    if (questions.isEmpty) return false;
    final currentQuestion = questions[currentQuestionIndex.value];
    return answers.containsKey(currentQuestion.questionNumber);
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }


  bool get isLastQuestion => currentQuestionIndex.value == questions.length - 1;
  
  int get totalAnswered => answers.length;
  int get totalQuestions => questions.length;
  bool get allQuestionsAnswered => totalAnswered == totalQuestions;
  
  int get progressPercentage => 
      totalQuestions > 0 ? ((currentQuestionIndex.value + 1) * 100 / totalQuestions).round() : 0;

  // Submit quiz
  Future<void> submitQuiz() async {
    if (!allQuestionsAnswered) {
      Get.snackbar(
        'Incomplete Quiz',
        'Please answer all questions before submitting',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (isSubmitting.value) return;

    isSubmitting.value = true;
    
    // Stop timer
    quizTimer?.cancel();
    final timeTaken = DateTime.now().difference(quizStartTime).inSeconds;

    // Prepare submission request - convert RxMap<int,int> to Map<String,int>
    final answersMap = Map<String, int>.fromEntries(
      answers.entries.map((entry) => MapEntry(entry.key.toString(), entry.value))
    );
    
    final request = QuizSubmissionRequest(
      quizId: quizData.value!.id,
      answers: answersMap,
      timeTaken: timeTaken,
    );

    final result = await repo.submitQuiz(request);
    isSubmitting.value = false;

    if (result != null && result.success) {
      submissionResult.value = result.data;
      Get.toNamed('/congrats');
    }
  }

  // Navigation helpers
  void goToLogin() {
    resetFlow();
    Get.offAllNamed('/login');
  }

  void backToCode() {
    Get.back();
  }

  void backToForm() {
    quizTimer?.cancel();
    Get.back();
  }

  // Validation methods
  String? validateReferralCodeInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Referral code is required';
    }
    if (value.length < 3) {
      return 'Please enter a valid referral code';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateOrganization(String? value) {
    if (value == null || value.isEmpty) {
      return 'Organization is required';
    }
    if (value.length < 2) {
      return 'Organization name must be at least 2 characters';
    }
    return null;
  }

  @override
  void onClose() {
    // Dispose controllers
    referralCodeController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    organizationController.dispose();
    
    // Cancel timer
    quizTimer?.cancel();
    
    super.onClose();
  }
}