import 'package:flutter/material.dart';
import 'entry_list_item.dart';
import 'entry_detail_screen.dart';

class EntryWidgets {
  static Widget buildSavedEntries(
      List<Map<String, String>> savedEntries,
      Future<void> Function(int index) deleteEntry,
      BuildContext context,
      ) {
    return SingleChildScrollView(
      child: Column(
        children: savedEntries.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> value = entry.value;
          return EntryListItemBlue(
            entry: value,
            index: index,
            onDelete: deleteEntry,
            onTap: (entry) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntryDetailScreen(entry: entry),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  static Widget buildForm(
      TextEditingController titleController,
      String selectedCategory,
      ValueChanged<String?> onCategoryChanged,
      DateTime selectedDateTime,
      VoidCallback selectDate,
      VoidCallback selectTime,
      VoidCallback pickImage,
      VoidCallback onNext,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Форма записи',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Название записи',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField(
          value: selectedCategory,
          items: ['Personal', 'Workout', 'Nutrition'].map((String category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: onCategoryChanged,
          decoration: InputDecoration(
            labelText: 'Категория',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text('Дата и время: '),
            TextButton(
              onPressed: selectDate,
              child: Text(
                '${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}',
              ),
            ),
            TextButton(
              onPressed: selectTime,
              child: Text(
                '${selectedDateTime.hour}:${selectedDateTime.minute}',
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text('Добавить фото: '),
            IconButton(
              icon: Icon(Icons.add_a_photo, color: Colors.blue),
              onPressed: pickImage,
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNext,
          child: Text('Далее'),
        ),
      ],
    );
  }

  static Widget buildTextField(
      TextEditingController additionalInfoController,
      VoidCallback onSave,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Дополнительная информация',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: additionalInfoController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Введите дополнительную информацию здесь',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSave,
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}
