import 'package:flutter/widgets.dart';
import './index.dart';

typedef TimeSelectCallback(int time);

class TimeOfDayPage extends StatelessWidget {
  const TimeOfDayPage(
      {Key key, @required this.forPeriod, this.onSelect, this.selectedHour})
      : super(key: key);

  final TimeSelectCallback onSelect;
  final DayPeriod forPeriod;
  final int selectedHour;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      crossAxisCount: 2,
      mainAxisSpacing: 40,
      crossAxisSpacing: 37,
      children: _buildGridItemList(),
    );
  }

  List<Widget> _buildGridItemList() {
    return DayPeriodHelper.periodHours(forPeriod)
        .map((hour) => _buildGridItem(hour, 100))
        .toList();
  }

  Widget _buildGridItem(int hour, int price) {
    final isSelected = selectedHour == hour;
    final contentBuilder =
        () => _buildItemContent(hour, price, true, isSelected);

    return GestureDetector(
        onTap: () => onSelect(hour),
        child: isSelected
            ? _buildSelectedItem(hour % 2 == 1, contentBuilder)
            : _buildNormalItem(contentBuilder));
  }

  _buildSelectedItem(bool isRight, Widget buildContent()) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: isRight
            ? Matrix4.translationValues(-20, -20, 0)
            : Matrix4.translationValues(20, -20, 0),
        width: 145,
        height: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.darkSlateBlue.withOpacity(0.12),
                offset: Offset(0, 16),
                blurRadius: 32),
            BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                offset: isRight ? Offset(20, 20) : Offset(-20, 20),
                blurRadius: 20)
          ],
        ),
        child: buildContent());
  }

  Widget _buildNormalItem(Widget buildContent()) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity(),
        width: 145,
        height: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.darkGray.withOpacity(0.1),
        ),
        child: buildContent());
  }

  Widget _buildItemContent(
      int hour, int price, bool isEnabled, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          _intToHourString(hour),
          style: TextStyles.airbnbCerealMedium.copyWith(
              fontSize: 24, color: isSelected ? Colors.white : Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "\$$price /",
                style: TextStyles.airbnbCerealMedium.copyWith(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.black)),
            TextSpan(
                text: " person",
                style: TextStyles.airbnbCerealBook.copyWith(
                    fontSize: 12,
                    color: (isSelected ? Colors.white : Colors.black)
                        .withOpacity(0.6)))
          ]),
        )
      ],
    );
  }

  String _intToHourString(int hour) {
    if (hour < 10) {
      return "0$hour:00";
    }

    return "$hour:00";
  }
}