import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HariKonsul extends StatefulWidget {
  final DoctorModel doctor;
  final VoidCallback onBack;

  const HariKonsul({super.key, required this.doctor, required this.onBack});

  @override
  State<HariKonsul> createState() => _HariKonsulState();
}

class _HariKonsulState extends State<HariKonsul> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Set<DateTime> _availableDays = {
    DateTime.utc(DateTime.now().year, DateTime.now().month, 10),
    DateTime.utc(DateTime.now().year, DateTime.now().month, 12),
    DateTime.utc(DateTime.now().year, DateTime.now().month, 15),
    DateTime.utc(DateTime.now().year, DateTime.now().month, 17),
    DateTime.utc(DateTime.now().year, DateTime.now().month, 20),
  };

  final List<String> _timeSlots = [
    '10:00 AM',
    '12:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  final List<int> _totalSlots = [5, 5, 5, 5, 5];
  final List<int> _usedSlots = [2, 3, 1, 4, 0];

  final List<int> _reminders = [30, 40, 25, 10, 35];

  int? _selectedTimeIndex;
  int? _selectedReminderIndex;

  bool _isAvailableDay(DateTime day) {
    return _availableDays.any(
      (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  int slotsLeft(int index) => _totalSlots[index] - _usedSlots[index];

  void _showThankYouPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 87,
                backgroundImage: AssetImage('assets/logo/thankyou.png'),
                backgroundColor: Colors.transparent,
              ),

              const SizedBox(height: 16),

              const Text(
                "Terima Kasih !",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Janji Temu Anda Berhasil",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 16),

              Text(
                "Anda telah membuat janji dengan Dr. ${widget.doctor.name} pada tanggal "
                "${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year} "
                "pukul ${_timeSlots[_selectedTimeIndex!]}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightColorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // tutup popup
                    widget.onBack(); // kembali ke halaman sebelumnya
                  },
                  child: const Text(
                    "Selesai",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = lightColorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TableCalendar(
              rowHeight: 45,
              daysOfWeekHeight: 40,
              firstDay: DateTime.utc(
                DateTime.now().year,
                DateTime.now().month,
                1,
              ),
              lastDay: DateTime.utc(
                DateTime.now().year,
                DateTime.now().month + 1,
                0,
              ),
              focusedDay: _focusedDay,
              selectedDayPredicate:
                  (day) =>
                      _selectedDay != null &&
                      day.year == _selectedDay!.year &&
                      day.month == _selectedDay!.month &&
                      day.day == _selectedDay!.day,
              onDaySelected: (selectedDay, focusedDay) {
                if (!_isAvailableDay(selectedDay)) return;
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedTimeIndex = null;
                  _selectedReminderIndex = null;
                });
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                disabledTextStyle: TextStyle(color: Colors.grey.shade400),
              ),
              enabledDayPredicate: _isAvailableDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedDay != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Time',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_timeSlots.length, (index) {
                        final isSelected = _selectedTimeIndex == index;
                        final left = slotsLeft(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTimeIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _timeSlots[index],
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$left slots left',
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white70
                                            : primaryColor.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Reminder Me Before',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_reminders.length, (index) {
                        final isSelected = _selectedReminderIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedReminderIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? primaryColor
                                      : primaryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_reminders[index]} Min',
                              style: TextStyle(
                                color: isSelected ? Colors.white : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                          (_selectedTimeIndex != null &&
                                  _selectedReminderIndex != null)
                              ? () {
                                _showThankYouPopup();
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
