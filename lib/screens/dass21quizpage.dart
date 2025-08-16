import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_iradat/screens/dass21resultscreen.dart';
import 'package:quiz_iradat/screens/quiz/likertquiz.dart';

class Dass21Question {
  final int questionId;
  final String questionContent;
  int? userAnswer;

  Dass21Question({
    required this.questionId,
    required this.questionContent,
    this.userAnswer,
  });
}

class Dass21QuizPage extends StatefulWidget {
  final String quizTitle;
  final String quizId;

  const Dass21QuizPage({super.key, required this.quizTitle, required this.quizId});

  @override
  State<Dass21QuizPage> createState() => _Dass21QuizPageState();
}

class _Dass21QuizPageState extends State<Dass21QuizPage> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  List<Dass21Question> questions = [];
  bool isLoading = true;

  Future<void> loadQuestions() async {
    try {
      final String jsonContent = await rootBundle.loadString(
        'lib/data/dass21.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonContent);
      final List<dynamic> questionsData = jsonData['quizzes'];

      setState(() {
        questions = questionsData
            .map(
              (question) => Dass21Question(
                questionId: question['questionNumber'],
                questionContent: question['questionContent'],
              ),
            )
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    loadQuestions().then((_) {
      if (questions.isNotEmpty) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _selectAnswer(int answer) {
    if (questions.isEmpty) return;

    setState(() {
      questions[currentQuestionIndex].userAnswer = answer;
    });
  }

  void _nextQuestion() {
    if (questions.isEmpty || currentQuestionIndex >= questions.length - 1) {
      return;
    }

    _slideController.reset();
    setState(() {
      currentQuestionIndex++;
    });
    _slideController.forward();
  }

  void _submitQuiz() {
    if (questions.isEmpty) {
      return;
    }

    // Collect all responses
    List<int> responses = questions.map((q) => q.userAnswer ?? 0).toList();

    // Navigate to results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dass21ResultsPage(
          quizTitle: widget.quizTitle,
          quizId: widget.quizId,
          questions: questions,
          responses: responses,
        ),
      ),
    );
  }

  bool get _isLastQuestion =>
      questions.isNotEmpty && currentQuestionIndex == questions.length - 1;
  bool get _canProceed =>
      questions.isNotEmpty &&
      currentQuestionIndex < questions.length &&
      questions[currentQuestionIndex].userAnswer != null;

  // Use a single neutral color throughout the quiz to avoid psychological bias
  Color get _getNeutralColor {
    return const Color(0xFF4A90A4); // Calming blue-teal color
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading questions...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
              const SizedBox(height: 16),
              Text(
                'Failed to load questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please try again',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  loadQuestions();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.quizTitle,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final isSmallScreen = screenWidth < 360;
            final isShortScreen = screenHeight < 600;
            
            // Adaptive sizing
            final horizontalMargin = isSmallScreen ? 12.0 : 20.0;
            final cardPadding = isSmallScreen ? 16.0 : 24.0;
            final iconSize = isSmallScreen ? 24.0 : 32.0;
            final questionFontSize = isSmallScreen ? 16.0 : 20.0;
            final progressFontSize = isSmallScreen ? 14.0 : 16.0;
            final buttonFontSize = isSmallScreen ? 14.0 : 16.0;
            final spacingLarge = isShortScreen ? 16.0 : 24.0;
            final spacingMedium = isShortScreen ? 12.0 : 20.0;
            final spacingSmall = isShortScreen ? 24.0 : 40.0;

            return Column(
              children: [
                // Progress Bar
                Container(
                  margin: EdgeInsets.all(horizontalMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Question ${currentQuestionIndex + 1} of ${questions.length}",
                              style: TextStyle(
                                fontSize: progressFontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${(progress * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: progressFontSize,
                              fontWeight: FontWeight.w600,
                              color: _getNeutralColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(_getNeutralColor),
                          minHeight: isSmallScreen ? 6 : 8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Question Card - Made scrollable to prevent overflow
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight * 0.5,
                      ),
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: .1),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Question Icon
                              Container(
                                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                                decoration: BoxDecoration(
                                  color: _getNeutralColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.psychology_outlined,
                                  size: iconSize,
                                  color: _getNeutralColor,
                                ),
                              ),
                              SizedBox(height: spacingLarge),

                              // Question Text
                              Text(
                                currentQuestion.questionContent,
                                style: TextStyle(
                                  fontSize: questionFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: spacingSmall),

                              // Likert Quiz Widget
                              LikertQuiz(
                                question: currentQuestion.questionContent,
                                onChanged: _selectAnswer,
                                initialValue: currentQuestion.userAnswer,
                              ),

                              SizedBox(height: spacingMedium),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Navigation Buttons
                Container(
                  margin: EdgeInsets.all(horizontalMargin),
                  child: Row(
                    children: [
                      // Next/Submit Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _canProceed
                              ? (_isLastQuestion ? _submitQuiz : _nextQuestion)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getNeutralColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12 : 16
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  _isLastQuestion ? "Lihat Hasil" : "Lanjut",
                                  style: TextStyle(
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _isLastQuestion ? Icons.analytics : Icons.arrow_forward,
                                size: isSmallScreen ? 18 : 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}