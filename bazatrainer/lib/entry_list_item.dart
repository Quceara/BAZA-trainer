import 'package:flutter/material.dart';
import 'dart:io';

abstract class AbstractEntryListItem extends StatelessWidget {
  final Map<String, String> entry;
  final int index;
  final Function(int) onDelete;
  final Function(Map<String, String>) onTap;

  AbstractEntryListItem({
    required this.entry,
    required this.index,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getBackgroundColor(),
      child: ListTile(
        leading: entry['imagePath']!.isNotEmpty
            ? Image.file(File(entry['imagePath']!),
            width: 50, height: 50, fit: BoxFit.cover)
            : null,
        title: Text(entry['title']!,
          style: TextStyle(
              color: Colors.white
          ),
        ),
        subtitle: Text(
          '${entry['category']} - ${entry['date']}\n${entry['additionalInfo']}',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            onDelete(index);
          },
        ),
        onTap: () {
          onTap(entry);
        },
      ),
    );
  }

  Color getBackgroundColor();
}

class EntryListItemBlue extends AbstractEntryListItem {
  EntryListItemBlue({
    required Map<String, String> entry,
    required int index,
    required Function(int) onDelete,
    required Function(Map<String, String>) onTap,
  }) : super(entry: entry, index: index, onDelete: onDelete, onTap: onTap);

  @override
  Color getBackgroundColor() {
    return Color.fromRGBO(14, 14, 14, 1)!;
  }
}

class EntryListItemGreen extends AbstractEntryListItem {
  EntryListItemGreen({
    required Map<String, String> entry,
    required int index,
    required Function(int) onDelete,
    required Function(Map<String, String>) onTap,
  }) : super(entry: entry, index: index, onDelete: onDelete, onTap: onTap);

  @override
  Color getBackgroundColor() {
    return Colors.green[50]!;
  }
}
