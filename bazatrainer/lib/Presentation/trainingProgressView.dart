import 'package:bazatrainer/Presentation/trainingProgressTimerView.dart';
import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import '../Domain/workoutTracker.dart';
import 'bottom_menu.dart';
import '../note.dart';

class TrainingProgressView extends StatelessWidget {
  static const String routeName = '/trainingProgressView';
  final WorkoutTracker workoutTracker = WorkoutTracker();
  final Map<String, dynamic> exercise;

  TrainingProgressView({required this.exercise});

  Widget _buildStepItem(String stepNumber, String stepDescription) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              stepNumber,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              stepDescription,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stepWidgets = [];
    for (var i = 0; i < exercise['steps'].length; i++) {
      var step = exercise['steps'][i];
      stepWidgets.add(_buildStepItem((i + 1).toString(), step['description']));
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'УПРАЖНЕНИЕ',
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
      body: Container(
        color: Color.fromRGBO(27, 27, 27, 1),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Block with Image
              Container(
                padding: EdgeInsets.all(16.0),
                child: Image.network(
                  exercise['image_url'],
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // workoutTracker.moveToNextExercise();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingProgressTimerView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('ПРОДОЛЖИТЬ'),
              ),
              // Exercise Title
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  exercise['title'],
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              // Exercise Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  exercise['description'],
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              // Step-by-step instructions
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Инструкция к выполнению:',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Column(
                children: stepWidgets,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
