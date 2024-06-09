import 'package:flutter/material.dart';
import 'package:bazatrainer/menu.dart';
import 'bottom_menu.dart';
import '../note.dart';

class ExerciseView extends StatelessWidget {
  static const String routeName = '/exerciseView';
  final String title;
  final String imageUrl;
  final String description;
  final List<String> steps;

  ExerciseView({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.steps,
  });

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: const Center(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Block with Image
            Container(
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Exercise Title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            // Exercise Description
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                description,
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
              children: steps
                  .asMap()
                  .entries
                  .map((entry) => _buildStepItem(
                  (entry.key + 1).toString(), entry.value))
                  .toList(),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
