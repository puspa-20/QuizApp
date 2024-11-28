import 'question.dart';

class QuestionEngine {
  int _questionNumber = 0;
  int correctAnswers = 0;

  final List<Question> _questionList = [
    Question(
      'What is the capital of Australia?',
      ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
      'Canberra',
      [-1, -1, 2, -1],
    ),
    Question(
      'Which element has the atomic number 1?',
      ['Oxygen', 'Hydrogen', 'Carbon', 'Helium'],
      'Hydrogen',
      [-1, 2, -1, -1],
    ),
    Question(
      'Who painted the Mona Lisa?',
      [
        'Vincent van Gogh',
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Claude Monet'
      ],
      'Leonardo da Vinci',
      [-1, 2, -1, -1],
    ),
    Question(
      'What is the largest planet in our Solar System?',
      ['Earth', 'Saturn', 'Jupiter', 'Neptune'],
      'Jupiter',
      [-1, -1, 2, -1],
    ),
    Question(
      'What is the national animal of India?',
      ['Elephant', 'Lion', 'Peacock', 'Tiger'],
      'Tiger',
      [-1, -1, -1, 2],
    ),
    Question(
      'What is the name of the longest river in the world?',
      ['Amazon', 'Nile', 'Yangtze', 'Mississippi'],
      'Nile',
      [-1, 2, -1, -1],
    ),
    Question(
      'Who developed the theory of relativity?',
      ['Isaac Newton', 'Nikola Tesla', 'Albert Einstein', 'Stephen Hawking'],
      'Albert Einstein',
      [-1, -1, 2, -1],
    ),
    Question(
      'Which organ in the human body is responsible for pumping blood?',
      ['Liver', 'Heart', 'Kidney', 'Lung'],
      'Heart',
      [-1, 2, -1, -1],
    ),
    Question(
      'What is the hardest natural substance on Earth?',
      ['Gold', 'Diamond', 'Steel', 'Quartz'],
      'Diamond',
      [-1, 2, -1, -1],
    ),
    Question(
      'Which ocean is the largest by surface area?',
      ['Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'],
      'Pacific Ocean',
      [-1, -1, 2, -1],
    ),
  ];

  int getQuestionsCount() {
    return _questionList.length;
  }

  void nextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionTextForCurrentQuestion() {
    return _questionList[_questionNumber].questionText;
  }

  List<String> getAnswers() {
    return _questionList[_questionNumber].answersList;
  }

  List<int> getScoreFromAnswers() {
    return _questionList[_questionNumber].answerWeight;
  }

  String getCorrectAnswer() {
    return _questionList[_questionNumber].correctAnswer;
  }

  bool didFinishQuiz() {
    return _questionNumber >= _questionList.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}
