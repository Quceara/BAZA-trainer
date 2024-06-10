import 'package:bazatrainer/Presentation/trainingProgrammView.dart';
import 'package:bazatrainer/Presentation/trainingProgressView.dart';
import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import '../Domain/workoutTracker.dart';
import 'bottom_menu.dart';
import '../note.dart';

class TrainingProgressTimerView extends StatelessWidget {
  static const String routeName = '/trainingProgressTimer';
  final WorkoutTracker workoutTracker = WorkoutTracker();

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: const Center(
          child: Text(
            'Тренировка. Отдых.',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      drawer: CustomDrawer(),
      endDrawer: CustomNotification(),
      body: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Color.fromRGBO(27, 27, 27, 1),
              body: Center(
                child: CircularCountDownTimer(
                  duration: 3,
                  initialDuration: 0,
                  controller: _controller,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  ringColor: Colors.grey[300]!,
                  fillColor: Colors.blue,
                  backgroundColor: Colors.blue[500],
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: () {
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    workoutTracker.moveToNextExercise();
                    if(workoutTracker.currentWorkout != null){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingProgressView(
                            exercise: workoutTracker.getCurrentExercise()!,
                          ),
                        ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Тренировка успешно пройдена!")),
                      );
                      Navigator.of(context).pushReplacementNamed(TrainingProgrammView.routeName);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('ПРОДОЛЖИТЬ'),
                ),
                BottomMenu(
                  currentIndex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
