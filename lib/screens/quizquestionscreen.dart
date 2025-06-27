import 'package:flutter/material.dart';
import 'package:quiz_iradat/screens/quizresultscreen.dart';

class QuizQuestion {
  final String question;
  bool? userAnswer;

  QuizQuestion({required this.question, this.userAnswer});
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

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "Do you prefer spending time alone rather than with others?",
    ),
    QuizQuestion(
      question: "Do you often feel energized after social gatherings?",
    ),
    QuizQuestion(
      question: "Do you find it easy to start conversations with strangers?",
    ),
    QuizQuestion(
      question:
          "Do you prefer to plan things in advance rather than being spontaneous?",
    ),
    QuizQuestion(
      question: "Do you often worry about things that might go wrong?",
    ),
    QuizQuestion(
      question: "Do you enjoy taking risks and trying new experiences?",
    ),
    QuizQuestion(
      question: "Do you tend to focus on details rather than the big picture?",
    ),
    QuizQuestion(
      question: "Do you make decisions based on logic rather than emotions?",
    ),
    QuizQuestion(
      question: "Do you prefer working in a team rather than independently?",
    ),
    QuizQuestion(
      question: "Do you often think about the future rather than the present?",
    ),
    QuizQuestion(
      question: "Do you find it difficult to express your emotions?",
    ),
    QuizQuestion(
      question: "Do you prefer routine and predictability over change?",
    ),
    QuizQuestion(
      question: "Do you often feel overwhelmed by too many choices?",
    ),
    QuizQuestion(question: "Do you enjoy being the center of attention?"),
    QuizQuestion(question: "Do you tend to be optimistic about outcomes?"),
    QuizQuestion(
      question: "Do you prefer to finish one task before starting another?",
    ),
    QuizQuestion(
      question: "Do you often analyze situations before taking action?",
    ),
    QuizQuestion(
      question:
          "Do you feel comfortable sharing personal information with others?",
    ),
    QuizQuestion(
      question: "Do you prefer competitive activities over collaborative ones?",
    ),
    QuizQuestion(
      question: "Do you often seek advice from others before making decisions?",
    ),
  ];

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
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _selectAnswer(bool answer) {
    setState(() {
      questions[currentQuestionIndex].userAnswer = answer;
    });

    // Auto proceed to next question after a short delay
    if (currentQuestionIndex < questions.length - 1) {
      Future.delayed(Duration(milliseconds: 500), () {
        _slideController.reset();
        setState(() {
          currentQuestionIndex++;
        });
        _slideController.forward();
      });
    }
  }

  void _submitQuiz() {
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

  bool get _isLastQuestion => currentQuestionIndex == questions.length - 1;
  bool get _canProceed => questions[currentQuestionIndex].userAnswer != null;

  @override
  Widget build(BuildContext context) {
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
                          currentQuestion.question,
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
                        Row(
                          children: [
                            Expanded(
                              child: _buildAnswerButton(
                                answer: true,
                                label: "YES",
                                icon: Icons.check_circle,
                                color: Colors.green,
                                isSelected: currentQuestion.userAnswer == true,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildAnswerButton(
                                answer: false,
                                label: "NO",
                                icon: Icons.cancel,
                                color: Colors.red,
                                isSelected: currentQuestion.userAnswer == false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Submit Button (only show on last question)
            if (_isLastQuestion && _canProceed)
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Submit Quiz",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.check, size: 20),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton({
    required bool answer,
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _selectAnswer(answer),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: .1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isSelected ? color.withValues(alpha: .2) : Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
