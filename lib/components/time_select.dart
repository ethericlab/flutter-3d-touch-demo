import 'package:flutter/widgets.dart';
import './index.dart';

class TimeSelect extends StatefulWidget {
  const TimeSelect({Key key, this.onCardToggle}) : super(key: key);

  final VoidCallback onCardToggle;

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  var _selectedDayPeriod = DayPeriod.morning;
  int _selectedHour;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            DayPeriodSelect(
              selectedPeriod: _selectedDayPeriod,
              onSelect: _handlePeriodSelect,
              onCardToggle: widget.onCardToggle,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _handlePageChange,
                children: <Widget>[
                  TimeOfDayPage(
                    forPeriod: DayPeriod.morning,
                    onSelect: _handleTimeSelect,
                    selectedHour: _selectedHour,
                  ),
                  TimeOfDayPage(
                    forPeriod: DayPeriod.day,
                    onSelect: _handleTimeSelect,
                    selectedHour: _selectedHour,
                  ),
                  TimeOfDayPage(
                    forPeriod: DayPeriod.evening,
                    onSelect: _handleTimeSelect,
                    selectedHour: _selectedHour,
                  ),
                ],
              ),
            )
          ],
        ),
        AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: 0,
            right: 0,
            bottom: _selectedHour != null ? 0 : -88,
            height: 88,
            child: BookFragment(
              price: 100,
            )),
      ],
    );
  }

  int _periodToPageIndex(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return 0;
      case DayPeriod.day:
        return 1;
      case DayPeriod.evening:
        return 2;

      default:
        return 0;
    }
  }

  DayPeriod _pageIndexToPeriod(int page) {
    switch (page) {
      case 0:
        return DayPeriod.morning;
      case 1:
        return DayPeriod.day;
      case 2:
        return DayPeriod.evening;

      default:
        return DayPeriod.morning;
    }
  }

  void _handlePageChange(int page) {
    setState(() {
      _selectedDayPeriod = _pageIndexToPeriod(page);
    });
  }

  void _handlePeriodSelect(DayPeriod period) {
    _pageController
        .animateToPage(_periodToPageIndex(period),
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut)
        .whenComplete(() {
      setState(() => _selectedDayPeriod = period);
    });
  }

  void _handleTimeSelect(int hour) {
    setState(() {
      _selectedHour = _selectedHour == hour ? null : hour;
    });
  }
}