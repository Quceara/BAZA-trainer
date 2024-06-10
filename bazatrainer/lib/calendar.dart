import 'package:flutter/material.dart';

class DatePickerDemo extends StatefulWidget {
  final int initialValueDay;
  final int initialValueMonth;
  final int initialValueYear;
  final int maxYear;
  final Function(int, int, int) onDateChanged;
  final Color backgroundColor;

  DatePickerDemo({
    required this.initialValueDay,
    required this.initialValueMonth,
    required this.initialValueYear,
    required this.maxYear,
    required this.onDateChanged,
    required this.backgroundColor,
  });

  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialValueDay;
    _selectedMonth = widget.initialValueMonth;
    _selectedYear = widget.initialValueYear;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomDatePicker(
              initialValueDay: _selectedDay,
              initialValueMonth: _selectedMonth,
              initialValueYear: _selectedYear,
              maxYear: widget.maxYear,
              onDateChanged: (day, month, year) {
                setState(() {
                  _selectedDay = day;
                  _selectedMonth = month;
                  _selectedYear = year;
                });
                widget.onDateChanged(day, month, year);
              },
              backgroundColor: widget.backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatelessWidget {
  final int initialValueDay;
  final int initialValueMonth;
  final int initialValueYear;
  final int maxYear;
  final Function(int, int, int) onDateChanged;
  final Color backgroundColor;

  CustomDatePicker({
    required this.initialValueDay,
    required this.initialValueMonth,
    required this.initialValueYear,
    required this.maxYear,
    required this.onDateChanged,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxDaysInMonth = _daysInMonth(initialValueMonth, initialValueYear);

    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPicker(
            value: initialValueDay,
            minValue: 1,
            maxValue: maxDaysInMonth,
            onChanged: (value) => onDateChanged(value, initialValueMonth, initialValueYear),
          ),
          _buildPicker(
            value: initialValueMonth,
            minValue: 1,
            maxValue: 12,
            onChanged: (value) {
              final newMaxDaysInMonth = _daysInMonth(value, initialValueYear);
              if (initialValueDay > newMaxDaysInMonth) {
                onDateChanged(newMaxDaysInMonth, value, initialValueYear);
              } else {
                onDateChanged(initialValueDay, value, initialValueYear);
              }
            },
          ),
          _buildPicker(
            value: initialValueYear,
            minValue: 1900,
            maxValue: maxYear,
            onChanged: (value) => onDateChanged(initialValueDay, initialValueMonth, value),
          ),
        ],
      ),
    );
  }

  Widget _buildPicker({required int value, required int minValue, required int maxValue, required Function(int) onChanged}) {
    return Container(
      height: 150,
      width: 100,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 30,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(maxValue - minValue + 1, (index) {
            final currentValue = minValue + index;
            return Center(
              child: Text(
                currentValue.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: value == currentValue ? Colors.white : Colors.grey,
                  fontWeight: value == currentValue ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Montserrat',
                ),
              ),
            );
          }),
        ),
        controller: FixedExtentScrollController(initialItem: value - minValue),
        onSelectedItemChanged: (index) => onChanged(minValue + index),
      ),
    );
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return 29;
      } else {
        return 28;
      }
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      return 31;
    }
  }
}
