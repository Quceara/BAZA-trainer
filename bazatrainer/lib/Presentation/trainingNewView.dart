import 'package:bazatrainer/Presentation/trainingProgrView.dart';
import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'bottom_menu.dart';
import '../note.dart';
import '../Data/trainingService.dart';

class TrainingNewView extends StatefulWidget {
  static const String routeName = '/trainingNewView';

  @override
  _TrainingNewViewState createState() => _TrainingNewViewState();
}

class _TrainingNewViewState extends State<TrainingNewView> {
  final TextEditingController _titleController = TextEditingController();
  XFile? _avatarImage;
  List<Map<String, dynamic>> _exercises = [];
  Set<int> _selectedExercises = Set<int>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    final exercises = await TrainingService().getExercises();
    setState(() {
      _exercises = exercises;
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _avatarImage = image;
    });
  }

  void _toggleExerciseSelection(int exerciseId) {
    setState(() {
      if (_selectedExercises.contains(exerciseId)) {
        _selectedExercises.remove(exerciseId);
      } else {
        _selectedExercises.add(exerciseId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = _avatarImage != null && _titleController.text.isNotEmpty && _selectedExercises.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'Новая тренировка',
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
          Expanded(
            child: Container(
              color: Color.fromRGBO(27, 27, 27, 1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (_avatarImage != null)
                      Image.file(
                        File(_avatarImage!.path),
                        width: 100,
                        height: 100,
                      ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Загрузить аватар'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _titleController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Название тренировки',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Выберите упражнения:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) {
                          final exerciseId = _exercises[index]['id'];
                          bool isSelected = _selectedExercises.contains(exerciseId);
                          return GestureDetector(
                            onTap: () => _toggleExerciseSelection(exerciseId),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.green[700] : Colors.grey[800],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  _exercises[index]['title'],
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: isFormValid ? () async {
                        final title = _titleController.text;
                        final path = '${DateTime.now().millisecondsSinceEpoch}_${_avatarImage!.name}';
                        final file = File(_avatarImage!.path);
                        final exerciseIds = _selectedExercises.toList();

                        try {
                          bool workoutExists = await TrainingService().doesWorkoutExist(title);
                          if (workoutExists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Тренировка с таким названием уже существует.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            await TrainingService().createWorkout(title, path, file, exerciseIds);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Тренировка успешно создана!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                                TrainingProgrView.routeName
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ошибка при создании тренировки: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid ? Colors.blue : Colors.grey,
                      ),
                      child: Text('Создать тренировку'),
                    ),
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
