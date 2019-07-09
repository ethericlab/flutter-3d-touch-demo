import 'package:flutter/widgets.dart';
import './index.dart';

typedef void DayPeriodSelectCallback(DayPeriod period);

enum DayPeriod { morning, day, evening }

class DayPeriodHelper {
  /// Generates a list that contains hours for the [period]
  static List<int> periodHours(DayPeriod period) {
    return List.generate(8, (index) {
      switch (period) {
        case DayPeriod.morning:
          return index + 4;
        case DayPeriod.day:
          return index + 12;
        case DayPeriod.evening:
          return (index + 20) % 24;

        default:
          return index;
      }
    });
  }

  /// Returns starting hour for the [period]
  static int periodToStartingHour(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return 4;
      case DayPeriod.day:
        return 12;
      case DayPeriod.evening:
        return 20;

      default:
        return 0;
    }
  }

  /// Returns a string representation of the [period]
  static String periodToString(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return "Morning";
      case DayPeriod.day:
        return "Day";
      case DayPeriod.evening:
        return "Evening";

      default:
        return "";
    }
  }
}

class DayPeriodSelect extends StatelessWidget {
  const DayPeriodSelect(
      {Key key,
        this.onSelect,
        this.selectedPeriod = DayPeriod.morning,
        this.onCardToggle})
      : super(key: key);

  final DayPeriodSelectCallback onSelect;
  final VoidCallback onCardToggle;
  final DayPeriod selectedPeriod;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.gray.withOpacity(0.2)))),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildLabel(
                      DayPeriod.morning, selectedPeriod == DayPeriod.morning),
                  _buildLabel(DayPeriod.day, selectedPeriod == DayPeriod.day),
                  _buildLabel(
                      DayPeriod.evening, selectedPeriod == DayPeriod.evening)
                ]),
          ],
        ),
        Positioned(
          top: 22,
          right: 5,
          child: _buildToggleButton(),
        )
      ],
    );
  }

  Widget _buildLabel(DayPeriod period, bool active) {
    return GestureDetector(
      onTap: () => onSelect(period),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                active ? BorderSide(color: Colors.blue) : BorderSide.none)),
        child: Padding(
          padding: EdgeInsets.only(left: 7, right: 7, bottom: 18, top: 18),
          child: Text(
            DayPeriodHelper.periodToString(period),
            style: (active
                ? TextStyles.airbnbCerealMedium
                : TextStyles.airbnbCerealBook)
                .copyWith(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return TapOpacity(
      onTap: onCardToggle,
      child: Container(
        width: 40,
        height: 40,
        child: Image(
          width: 25,
          height: 25,
          image: AssetImage('images/colon.png'),
        ),
      ),
    );
  }
}