import 'package:flutter/material.dart';
import 'package:kalkulator_beta_01/screen/kalender/events.dart';
import 'package:table_calendar/table_calendar.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedToDay = DateTime.now();
  DateTime? selectedToDay;
  Map<DateTime, List<Event>> events = {};
  TextEditingController eventController = TextEditingController();
  late final ValueNotifier<List<Event>> selectedEvents;

  @override
  void initState() {
    super.initState();
    selectedToDay = focusedToDay;
    selectedEvents = ValueNotifier(getEventsForDay(selectedToDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapDaySeleted(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedToDay, selectedDay)) {
      setState(() {
        selectedToDay = selectedDay;
        focusedToDay = focusedDay;
        selectedEvents.value = getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text("Penambahan Event"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: eventController,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      events.addAll({
                        selectedToDay!: [Event(eventController.text)]
                      });
                      Navigator.of(context).pop();
                      selectedEvents.value = getEventsForDay(selectedToDay!);
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_US',
              rowHeight: 43,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2040, 3, 14),
              focusedDay: focusedToDay,
              selectedDayPredicate: (day) => isSameDay(selectedToDay, day),
              calendarFormat: calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: onTapDaySeleted,
              eventLoader: getEventsForDay,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (calendarFormat != format) {
                  setState(() {
                    calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                focusedToDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () {},
                            title: Text(value[index].tittle),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
