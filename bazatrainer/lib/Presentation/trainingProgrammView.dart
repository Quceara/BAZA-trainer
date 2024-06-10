import 'package:bazatrainer/Domain/sessionManager.dart';
import 'package:bazatrainer/Presentation/trainingNewView.dart';
import 'package:bazatrainer/Presentation/trainingStartView.dart';
import 'package:flutter/material.dart';
import 'package:bazatrainer/menu.dart';
import '../Data/trainingService.dart';
import '../Data/userService.dart';
import 'bottom_menu.dart';
import '../note.dart';
import 'exerciceView.dart';

class TrainingProgrammView extends StatefulWidget {
  static const String routeName = '/trainingProgrView';

  @override
  _TrainingProgrammViewState createState() => _TrainingProgrammViewState();
}

class _TrainingProgrammViewState extends State<TrainingProgrammView> {
  int _selectedIndex = 0;
  int? _expandedItemIndex;
  late Future<List<Map<String, dynamic>>> _workoutsFuture;
  late Future<String> nickname;

  @override
  void initState() {
    super.initState();
    _workoutsFuture = TrainingService().getWorkouts();
    nickname = UserService().getUserName();
  }

  void _selectMenu(int index) {
    setState(() {
      _selectedIndex = index;
      _expandedItemIndex = null;
    });
  }

  Widget _buildNewWorkoutButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(
              TrainingNewView.routeName
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.all(16.0),
        ),
        child: Text(
          'Новая тренировка',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }


  List<Map<String, dynamic>> _filterWorkouts(List<Map<String, dynamic>> workouts, String nickname) {
    if (_selectedIndex == 1) {

      return workouts.where((workout) => workout['trainer'] == nickname).toList();
    } else if (_selectedIndex == 2) {

      return workouts.where((workout) => workout['trainer'] == 'Baza Trainer').toList();
    } else {
      // Все тренировки
      return workouts;
    }
  }



  void _toggleExpandedItem(int index) {
    setState(() {
      if (_expandedItemIndex == index) {
        _expandedItemIndex = null;
      } else {
        _expandedItemIndex = index;
      }
    });
  }

  Widget _buildMenuItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        _selectMenu(index);
      },
      child: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.white : Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTrainingItem(int index, Map<String, dynamic> workout) {
    bool isExpanded = _expandedItemIndex == index;

    return GestureDetector(
      onTap: () => _toggleExpandedItem(index),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 125,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(workout['image_url'] ?? "https://via.placeholder.com/1000x500"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout['title'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        workout['trainer'] ?? 'Trainer',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        workout['date'] ?? 'Date',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isExpanded)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Упражнения',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => _toggleExpandedItem(index),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: workout['exercises'].length,
                      itemBuilder: (context, exerciseIndex) {
                        final exercise = workout['exercises'][exerciseIndex];
                        return _buildExerciseItem(exercise);
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print(workout);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingStartView(
                              workout: workout,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        'Начать тренировку',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseItem(Map<String, dynamic> exercise) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseView(
              title: exercise['title'],
              imageUrl: exercise['image_url'] ?? "https://via.placeholder.com/1000x500",
              description: exercise['description'],
              steps: List<String>.from(exercise['steps'].map((step) => step['description'])),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            exercise['title'],
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: const Center(
          child: Text(
            'Программы',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
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
          // Первая часть
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuItem(0, "Все"),
                _buildMenuItem(1, "Мои"),
                _buildMenuItem(2, "Готовые"),
              ],
            ),
          ),
          // Вторая часть
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _workoutsFuture,
              builder: (context, workoutSnapshot) {
                if (workoutSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (workoutSnapshot.hasError) {
                  return Center(child: Text('Error ${workoutSnapshot.error}'));
                } else if (!workoutSnapshot.hasData || workoutSnapshot.data!.isEmpty) {
                  return Center(child: Text('Трень нету...'));
                }

                return FutureBuilder<String>(
                  future: nickname,
                  builder: (context, nicknameSnapshot) {
                    if (nicknameSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (nicknameSnapshot.hasError) {
                      return Center(child: Text('Error ${nicknameSnapshot.error}'));
                    }

                    final filteredWorkouts = _filterWorkouts(workoutSnapshot.data!, nicknameSnapshot.data ?? "");
                    return ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: filteredWorkouts.length,
                      itemBuilder: (context, index) {
                        final workout = filteredWorkouts[index];
                        return _buildTrainingItem(index, workout);
                      },
                    );
                  },
                );
              },
            ),
          ),
          if (_selectedIndex == 1) _buildNewWorkoutButton(),
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
