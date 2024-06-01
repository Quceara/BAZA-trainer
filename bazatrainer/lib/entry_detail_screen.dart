import 'package:flutter/material.dart';
import 'dart:io';

class EntryDetailScreen extends StatelessWidget {
  final Map<String, String> entry;

  EntryDetailScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry['title']!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            entry['imagePath']!.isNotEmpty
                ? Image.file(File(entry['imagePath']!),
                width: double.infinity, height: 200, fit: BoxFit.cover)
                : Container(),
            SizedBox(height: 20),
            Text(
              'Категория: ${entry['category']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Дата и время: ${entry['date']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Дополнительная информация:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              entry['additionalInfo']!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
