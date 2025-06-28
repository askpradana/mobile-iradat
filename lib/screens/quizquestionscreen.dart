import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_iradat/screens/quizresultscreen.dart';
import 'package:quiz_iradat/screens/quiz/yesnoquiz.dart';

class QuizQuestion {
  final int questionId;
  final String questionContent;
  bool? userAnswer;

  QuizQuestion({
    required this.questionId,
    required this.questionContent,
    this.userAnswer,
  });
}

class QuizPage extends StatefulWidget {
  final String quizTitle;
  final String quizId;

  const QuizPage({super.key, required this.quizTitle, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  List<QuizQuestion> questions = []; // Initialize as empty list instead of late
  bool isLoading = true; // Add loading state

  Future<void> loadQuestions() async {
    try {
      final String jsonContent = await rootBundle.loadString(
        'lib/data/srq20.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonContent);
      final List<dynamic> questionsData = jsonData['quizzes'];

      setState(() {
        questions =
            questionsData
                .map(
                  (question) => QuizQuestion(
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

    // Load questions first, then start animation
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

  void _selectAnswer(bool answer) {
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
      // Don't modify the userAnswer here - let it keep its existing value
      // (null if unanswered, true/false if previously answered)
    });
    _slideController.forward();
  }

  void _submitQuiz() {
    if (questions.isEmpty) {
      return;
    }

    // Calculate statistics
    int yesCount = 0;
    int noCount = 0;

    for (var question in questions) {
      if (question.userAnswer == true) {
        yesCount++;
      } else if (question.userAnswer == false) {
        noCount++;
      }
    }

    // Navigate to results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => QuizResultsPage(
              quizTitle: widget.quizTitle,
              quizId: widget.quizId,
              questions: questions,
              yesCount: yesCount,
              noCount: noCount,
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: TextStyle(
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
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
              ),
              SizedBox(height: 16),
              Text(
                'Loading questions...',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quizTitle,
            style: TextStyle(
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
              SizedBox(height: 16),
              Text(
                'Failed to load questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please try again',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  loadQuestions();
                },
                child: Text('Retry'),
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
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.quizTitle,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${currentQuestionIndex + 1} of ${questions.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue[600]!,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            // Question Card
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .1),
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question Icon
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.help_outline,
                            size: 32,
                            color: Colors.blue[600],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Question Text
                        Text(
                          currentQuestion.questionContent,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),

                        // Answer Buttons
                        YesNoQuiz(
                          question: currentQuestion.questionContent,
                          onChanged: _selectAnswer,
                          initialValue: currentQuestion.userAnswer,
                        ),

                        // Answer Status Indicator
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  // Next/Submit Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _canProceed
                              ? (_isLastQuestion ? _submitQuiz : _nextQuestion)
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLastQuestion ? "Submit Quiz" : "Next",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            _isLastQuestion ? Icons.check : Icons.arrow_forward,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
