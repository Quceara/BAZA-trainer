import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'entry_widgets.dart';
import 'Presentation/bottom_menu.dart';

class EntryFormWidget extends StatefulWidget {
  static const String routeName = '/entryForm';

  @override
  _EntryFormWidgetState createState() => _EntryFormWidgetState();
}

class _EntryFormWidgetState extends State<EntryFormWidget> {
  String _selectedCategory = 'Personal';
  DateTime _selectedDateTime = DateTime.now();
  bool _isFormVisible = false;
  bool _isTextFieldVisible = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _additionalInfoController = TextEditingController();
  List<Map<String, String>> _savedEntries = [];
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadSavedEntries();
  }

  Future<void> _loadSavedEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final int entryCount = prefs.getInt('entry_count') ?? 0;
    List<Map<String, String>> loadedEntries = [];

    for (int i = 0; i < entryCount; i++) {
      String? title = prefs.getString('entry_title_$i');
      String? category = prefs.getString('entry_category_$i');
      String? date = prefs.getString('entry_date_$i');
      String? additionalInfo = prefs.getString('entry_additional_info_$i');
      String? imagePath = prefs.getString('entry_image_path_$i');

      if (title != null && category != null && date != null && additionalInfo != null) {
        loadedEntries.add({
          'title': title,
          'category': category,
          'date': date,
          'additionalInfo': additionalInfo,
          'imagePath': imagePath ?? '',
        });
      }
    }

    setState(() {
      _savedEntries = loadedEntries;
    });
  }

  Future<void> _saveEntry(Map<String, String> entry) async {
    final prefs = await SharedPreferences.getInstance();
    final int entryCount = prefs.getInt('entry_count') ?? 0;

    await prefs.setString('entry_title_$entryCount', entry['title']!);
    await prefs.setString('entry_category_$entryCount', entry['category']!);
    await prefs.setString('entry_date_$entryCount', entry['date']!);
    await prefs.setString('entry_additional_info_$entryCount', entry['additionalInfo']!);
    await prefs.setString('entry_image_path_$entryCount', entry['imagePath']!);
    await prefs.setInt('entry_count', entryCount + 1);

    _loadSavedEntries();
  }

  Future<void> _deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final int entryCount = prefs.getInt('entry_count') ?? 0;

    if (index < 0 || index >= entryCount) return;

    await prefs.remove('entry_title_$index');
    await prefs.remove('entry_category_$index');
    await prefs.remove('entry_date_$index');
    await prefs.remove('entry_additional_info_$index');
    await prefs.remove('entry_image_path_$index');

    for (int i = index; i < entryCount - 1; i++) {
      String? nextTitle = prefs.getString('entry_title_${i + 1}');
      String? nextCategory = prefs.getString('entry_category_${i + 1}');
      String? nextDate = prefs.getString('entry_date_${i + 1}');
      String? nextAdditionalInfo = prefs.getString('entry_additional_info_${i + 1}');
      String? nextImagePath = prefs.getString('entry_image_path_${i + 1}');

      if (nextTitle != null && nextCategory != null && nextDate != null && nextAdditionalInfo != null) {
        await prefs.setString('entry_title_$i', nextTitle);
        await prefs.setString('entry_category_$i', nextCategory);
        await prefs.setString('entry_date_$i', nextDate);
        await prefs.setString('entry_additional_info_$i', nextAdditionalInfo);
        await prefs.setString('entry_image_path_$i', nextImagePath!);
      }
    }

    await prefs.setInt('entry_count', entryCount - 1);
    _loadSavedEntries();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 27, 27, 1), // Изменение цвета фона страницы
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if (_isFormVisible)
                  (_isTextFieldVisible
                      ? EntryWidgets.buildTextField(
                    _additionalInfoController,
                    _submitForm,
                  )
                      : EntryWidgets.buildForm(
                    _titleController,
                    _selectedCategory,
                        (newValue) {
                      setState(() {
                        _selectedCategory = newValue.toString();
                      });
                    },
                    _selectedDateTime,
                        () => _selectDate(context),
                        () => _selectTime(context),
                    _pickImage,
                        () {
                      setState(() {
                        _isTextFieldVisible = true;
                      });
                    },
                  )),
                if (!_isFormVisible)
                  EntryWidgets.buildSavedEntries(
                    _savedEntries,
                    _deleteEntry,
                    context,
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: !_isFormVisible
          ? Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                onPressed: () {
                  setState(() {
                    _isFormVisible = true;
                  });
                },
                child: Text('Добавить запись',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  Future<void> _submitForm() async {
    Map<String, String> newEntry = {
      'title': _titleController.text,
      'category': _selectedCategory,
      'date': _selectedDateTime.toIso8601String(),
      'additionalInfo': _additionalInfoController.text,
      'imagePath': _imagePath ?? '',
    };

    await _saveEntry(newEntry);

    // Сброс формы
    setState(() {
      _isFormVisible = false;
      _isTextFieldVisible = false;
      _titleController.clear();
      _additionalInfoController.clear();
      _imagePath = null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDateTime = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
