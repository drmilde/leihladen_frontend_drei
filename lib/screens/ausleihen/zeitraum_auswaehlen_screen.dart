import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/reservierung_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/animated_button_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:table_calendar/table_calendar.dart';

class ZeitraumAuswaehlenScreen extends StatefulWidget {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));

  ZeitraumAuswaehlenScreen(this.startDate) {
    startDate = nextFriday(startDate);
    endDate = startDate.add(Duration(days: 7));
  }

  DateTime nextFriday(DateTime d) {
    int diff = 5 - d.weekday;
    if (diff < 0) {
      diff = diff + 7;
    }
    return d.add(Duration(days: diff));
  }

  String getUSDateString(DateTime d) {
    String year = "${d.year}";
    String month = (d.month < 10) ? "0${d.month}" : "${d.month}";
    String day = (d.day < 10) ? "0${d.day}" : "${d.day}";

    return ("${year}-${month}-${day}");
  }

  @override
  _ZeitraumAuswaehlenScreenState createState() =>
      _ZeitraumAuswaehlenScreenState();
}

class _ZeitraumAuswaehlenScreenState extends State<ZeitraumAuswaehlenScreen> {
  ReservierungScreenConfig config = ReservierungScreenConfig();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedDay = widget.startDate;
    _startDate = widget.nextFriday(widget.startDate);
    _endDate = _startDate.add(Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      showDrawer: false,
      appbar: AppBar(
        backgroundColor: config.getPrimaryColor(),
        title: Text("Leihzeitraum (1 Woche)"),
      ),
      showAppbar: true,
      fab: Container(),
      showFab: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("Gew??hlter Leihzeitraum:"),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Container(
              width: 300,
              color: config.getPrimaryColor(),
              child: Text(
                  "${_startDate.day}.${_startDate.month}.${_startDate.year} - "
                  "${_endDate.day}.${_endDate.month}.${_endDate.year}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              onDaySelected: _onDaySelected,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
            )),
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _startDate = widget.nextFriday(_selectedDay);
        _endDate = _startDate.add(Duration(days: 7));

        widget.startDate = _startDate;
        widget.endDate = _endDate;
      });
    }
  }
}
