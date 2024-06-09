import 'package:bazatrainer/Data/userService.dart';
import 'package:bazatrainer/Domain/sessionManager.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Domain/supabaseCli.dart';
import 'dart:io';

class TrainingService {
  final SupabaseClient _client = SupabaseCli().client;

  Future<List<Map<String, dynamic>>> getWorkouts() async {
    try {
      final response = await _client
          .from('workouts')
          .select('*, exercises(*)');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("TrainingService().getWorkouts() get error: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getExercises() async {
    try {
      final response = await _client
          .from('exercises')
          .select('id, title');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("TrainingService().getWorkouts() get error: $e");
      return [];
    }
  }

  Future<bool> doesWorkoutExist(String title) async {
    try {
      final response = await _client
          .from('workouts')
          .select('id')
          .eq('title', title)
          .maybeSingle();

      return response != null;
    } catch (e) {
      print("TrainingService().doesWorkoutExist() get error: $e");
      return false;
    }
  }

  Future<String?> uploadWorkoutImage(String path, File file) async {
    try {
      await _client
          .storage
          .from('trainings')
          .upload(path, file);

      final avatarUrl = _client.storage.from('trainings').getPublicUrl(path);

      return avatarUrl;

    } catch (e) {
      print("TrainingService().uploadWorkoutImage() get error: $e");
      return null;
    }
  }

  Future<void> createWorkout(String title, String path, File file, List<int> exerciseIds) async {
    try {
      final imageUrl = await uploadWorkoutImage(path, file);
      if (imageUrl == null) {
        throw Exception('Image upload failed');
      }

      final trainerName = await UserService().getUserName();
      print(trainerName);
      final workoutResponse = await _client
          .from('workouts')
          .insert({
        'title': title,
        'trainer': trainerName,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'image_url': imageUrl,
      })
          .select()
          .single();

      print(workoutResponse);

      final workoutId = workoutResponse['id'];
      print(workoutId);

      if (workoutId == null) {
        throw Exception('Invalid workout ID');
      }

      final workoutExercises = exerciseIds.map((exerciseId) => {
        'workout_id': workoutId,
        'exercise_id': exerciseId,
      }).toList();

      print(workoutExercises);

      await _client
          .from('workout_exercises')
          .insert(workoutExercises);

      print("Workout created successfully with exercises: $workoutResponse");
    } catch (e) {
      print("TrainingService().createWorkout() error: $e");
    }
  }

}
