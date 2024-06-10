import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class WorkoutTracker {
  static final WorkoutTracker _instance = WorkoutTracker._internal();

  Map<String, dynamic>? currentWorkout;
  int currentExerciseIndex = 0;
  static const String _currentWorkoutKey = 'currentWorkout';
  static const String _currentExerciseIndexKey = 'currentExerciseIndex';

  factory WorkoutTracker() {
    return _instance;
  }

  WorkoutTracker._internal();

  // Метод для инициализации тренировки
  void startWorkout(Map<String, dynamic> workout) {
    currentWorkout = workout;
    currentExerciseIndex = 0;
    saveProgress();
  }

  // Метод для получения текущего упражнения
  Map<String, dynamic>? getCurrentExercise() {
    if (currentWorkout == null || currentExerciseIndex >= currentWorkout!['exercises'].length) {
      return null;
    }
    return currentWorkout!['exercises'][currentExerciseIndex];
  }

  // Метод для перехода к следующему упражнению
  void moveToNextExercise() {
    if (currentWorkout != null && currentExerciseIndex < currentWorkout!['exercises'].length - 1) {
      currentExerciseIndex++;
      saveProgress();
    }else{
      finishWorkout();
    }
  }

  // Метод для сохранения прогресса тренировки
  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    if (currentWorkout != null) {
      prefs.setString(_currentWorkoutKey, jsonEncode(currentWorkout));
      prefs.setInt(_currentExerciseIndexKey, currentExerciseIndex);
    }
  }

  // Метод для восстановления прогресса тренировки
  Future<void> restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutString = prefs.getString(_currentWorkoutKey);
    if (workoutString != null) {
      currentWorkout = jsonDecode(workoutString);
      currentExerciseIndex = prefs.getInt(_currentExerciseIndexKey) ?? 0;
    }
  }

  // Метод для завершения тренировки
  void finishWorkout() {
    currentWorkout = null;
    currentExerciseIndex = 0;
    clearProgress();
  }

  // Метод для очистки сохраненного прогресса
  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_currentWorkoutKey);
    prefs.remove(_currentExerciseIndexKey);
  }
}
