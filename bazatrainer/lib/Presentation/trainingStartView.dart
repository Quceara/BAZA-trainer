import 'package:bazatrainer/Presentation/trainingProgrammView.dart';
import 'package:bazatrainer/Presentation/trainingProgressView.dart';
import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import '../Domain/workoutTracker.dart';
import 'bottom_menu.dart';
import '../note.dart';

class TrainingStartView extends StatefulWidget {
  static const String routeName = '/trainingStartView';
  final Map<String, dynamic> workout;


  TrainingStartView({required this.workout});

  @override
  State<TrainingStartView> createState() => _TrainingStartViewState();
}

class _TrainingStartViewState extends State<TrainingStartView> {
  final WorkoutTracker workoutTracker = WorkoutTracker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'Тренировка',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.message_outlined, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      endDrawer: CustomNotification(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(27, 27, 27, 1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.workout['image_url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(27, 27, 27, 1),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.workout['title'],
                                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Тренер: ${widget.workout['trainer']}',
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              Text(
                                'Дата: ${widget.workout['date']}',
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Restore progress to check if a workout is already in progress
                        await workoutTracker.restoreProgress();

                        if (workoutTracker.currentWorkout != null) {
                          // Show confirmation dialog if a workout is in progress
                          bool? confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Подтверждение'),
                                content: Text('У вас уже есть тренировка в процессе. Вы уверены, что хотите начать новую тренировку?'),
                                actions: [
                                  TextButton(
                                    child: Text('Продолжить прошлую'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Начать новую'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm == true) {
                            // Start new workout if user confirms
                            workoutTracker.startWorkout(widget.workout);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainingProgressView(
                                  exercise: workoutTracker.getCurrentExercise()!,
                                ),
                              ),
                            );
                          } else {
                            // Continue the previous workout
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainingProgressView(
                                  exercise: workoutTracker.getCurrentExercise()!,
                                ),
                              ),
                            );
                          }
                        } else {
                          // No workouts in progress, just start a new one
                          workoutTracker.startWorkout(widget.workout);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrainingProgressView(
                                exercise: workoutTracker.getCurrentExercise()!,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Начать тренировку!'),
                    ),
                    Text(
                      'Упражнения:',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ...widget.workout['exercises'].map<Widget>((exercise) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise['title'],
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ...exercise['steps'].map<Widget>((step) {
                              return Text(
                                '${step['stepNumber']}. ${step['description']}',
                                style: TextStyle(color: Colors.grey),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
            child: BottomMenu(
              currentIndex: 1,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
