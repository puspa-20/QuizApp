import 'package:flutter/material.dart';
import 'package:question_answer_app/question_engine.dart';

QuestionEngine questionEngine = QuestionEngine();

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  //hover part
  int hoveredIndex = -1;
  int correctCount = 0;
  int incorrectCount = 0;
  List<Widget> recordTracker = [];

  Future<void> _showDialog(
      String title, String bodyText, String buttonText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Set the radius for rounded corners
          side: BorderSide(
              color: Colors.white, width: 2), // Add border color and width
        ),
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Image(
                  width: 150,
                  height: 150,
                  image: AssetImage("assets/congratulations.png")),
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                bodyText,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 42, 52, 43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, 'OK');
                  questionEngine.reset();
                  score = 0;
                  correctCount = 0;
                  incorrectCount = 0;
                });
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkAnswer(String userSelectedAnswer, int weightValue) {
    String correctAnswer = questionEngine.getCorrectAnswer();

    setState(() {
      // first test: check if the quiz is finished
      if (questionEngine.didFinishQuiz()) {
        _showDialog("Congratulations", "You have come to the end of the quiz",
            "Start Again");
        questionEngine.reset();
        score = 0;
        recordTracker = [];
      } else {
        if (userSelectedAnswer == correctAnswer) {
          correctCount++;

          // recordTracker.add(
          //   const Icon(
          //     Icons.check_box,
          //     color: Colors.green,
          //     size: 30,
          //   ),
          // );
        } else {
          incorrectCount++;
          // recordTracker.add(
          //   const Icon(
          //     Icons.close,
          //     color: Colors.red,
          //     size: 30,
          //   ),
          // );
        }
        score += weightValue;
      }
      questionEngine.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                questionEngine.getQuestionTextForCurrentQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        // ListView.builder(
        //     itemCount: 4,
        //     scrollDirection: Axis.vertical,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(15.0),
        //         child: MaterialButton(
        //           textColor: Colors.white,
        //           color: Colors.blue,
        //           child: Padding(
        //             padding: const EdgeInsets.all(12.0),
        //             child: Text(
        //               questionEngine.getAnswers()[index],
        //               style: const TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 20.0,
        //               ),
        //             ),
        //           ),
        //           onPressed: () {
        //             //The user picked this answer.
        //             setState(() {
        //               checkAnswer(questionEngine.getAnswers()[index],
        //                   questionEngine.getScoreFromAnswers()[index]);
        //             });
        //           },
        //         ),
        //       );
        //     }),
        ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    hoveredIndex = index;
                    print("Hovered Index: $hoveredIndex");
                  });
                },
                onExit: (_) {
                  setState(() {
                    hoveredIndex = -1;
                    print("Hovered Index: $hoveredIndex");
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: hoveredIndex == index
                        ? const Color.fromARGB(255, 97, 97, 95)
                        : Colors.transparent,
                    border: Border.all(
                      color: hoveredIndex == index
                          ? Colors.transparent
                          : Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        questionEngine.getAnswers()[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // The user picked this answer.
                      setState(() {
                        checkAnswer(questionEngine.getAnswers()[index],
                            questionEngine.getScoreFromAnswers()[index]);
                      });
                    },
                  ),
                ),
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Score: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    '$score',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Correct: ',
                    style: TextStyle(
                        color: Color.fromARGB(210, 51, 99, 51),
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    '$correctCount',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 67, 117, 68),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Incorrect: ',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    '$incorrectCount',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
