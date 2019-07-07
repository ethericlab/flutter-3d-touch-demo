import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import './common.dart';

void main() => runApp(RestaurnatDemo());

class RestaurnatDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Flutter 3D Touch demo',
      color: Color(0xff060518),
      home: Home(),
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          PageRouteBuilder<T>(
            pageBuilder: (BuildContext context, _, __) => builder(context),
          ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 60),
          AppBar(),
          SizedBox(
            height: 43,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[RestaurantSelect(), TimeSelect()],
            ),
          )
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildMenuButton(),
          Spacer(),
          _buildUserName(),
          SizedBox(
            width: 14,
          ),
          _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildMenuButton() {
    return Image(
        height: 20, width: 20, image: AssetImage('images/menu_button.png'));
  }

  Widget _buildUserName() {
    return Text(
      'Andriy Pryvalov',
      style: TextStyles.airbnbCerealMedium.copyWith(fontSize: 16),
    );
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image(
        height: 34,
        width: 34,
        image: AssetImage('images/avatar.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class RestaurantSelect extends StatelessWidget {
  RestaurantSelect({Key key}) : super(key: key);

  final List<String> _restaurantImages = const [
    "images/burger_king.png",
    "images/mc_donalds.png",
    "images/bageterie.png",
    "images/starbucks.png"
  ];
  final List<String> _restaurantNames = const [
    "Burger King",
    "Mc Donalds",
    "BB",
    "Starbucks"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitleLabel(),
        SizedBox(
          height: 50,
        ),
        _buildRestaurantList(),
      ],
    );
  }

  Widget _buildTitleLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        "Select\nthe restaurant",
        style: TextStyles.airbnbCerealMedium.copyWith(fontSize: 28),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _restaurantNames.length,
        separatorBuilder: (BuildContext context, _) => SizedBox(
              width: 16,
            ),
        padding: EdgeInsets.only(left: 24),
        itemBuilder: (BuildContext context, int index) => _buildRestaurantItem(
            _restaurantImages[index], _restaurantNames[index]),
      ),
    );
  }

  Widget _buildRestaurantItem(String image, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(height: 120, width: 90, image: AssetImage(image)),
        ),
        SizedBox(
          height: 14,
        ),
        Text(name, style: TextStyles.airbnbCerealBook.copyWith(fontSize: 12))
      ],
    );
  }
}

class TimeSelect extends StatefulWidget {
  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  DayPeriod _selectedDayPeriod = DayPeriod.morning;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
  }

  int _periodToTime(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return 4;
      case DayPeriod.day:
        return 12;
      case DayPeriod.evening:
        return 20;
    }
  }

  void handleSelectPeriod(DayPeriod period) {
    _scrollController.animateTo(40 + (_periodToTime(period) / 2) * (145 + 40),
        curve: Curves.easeInOutCubic, duration: Duration(milliseconds: 400));

      setState(() {
        _selectedDayPeriod = period;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34), topRight: Radius.circular(34)),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 34),
            DayPeriodSelect(
              selectedPeriod: _selectedDayPeriod,
              onSelect: handleSelectPeriod,
            ),
            Expanded(
              child: TimeOfDaySelect(
                controller: _scrollController,
              ),
            )
          ],
        ));
  }
}

typedef void DayPeriodSelectCallback(DayPeriod period);

enum DayPeriod { morning, day, evening }

class DayPeriodSelect extends StatelessWidget {
  const DayPeriodSelect(
      {Key key, this.onSelect, this.selectedPeriod = DayPeriod.morning})
      : super(key: key);

  final DayPeriodSelectCallback onSelect;
  final DayPeriod selectedPeriod;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.gray.withOpacity(0.2)))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildLabel(DayPeriod.morning, selectedPeriod == DayPeriod.morning),
            _buildLabel(DayPeriod.day, selectedPeriod == DayPeriod.day),
            _buildLabel(DayPeriod.evening, selectedPeriod == DayPeriod.evening)
          ]),
    );
  }

  String _convertDayPeriodToString(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return "Morning";
      case DayPeriod.day:
        return "Day";
      case DayPeriod.evening:
        return "Evening";
    }
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
          padding: EdgeInsets.only(left: 7, right: 7, bottom: 14),
          child: Text(
            _convertDayPeriodToString(period),
            style: (active
                    ? TextStyles.airbnbCerealMedium
                    : TextStyles.airbnbCerealBook)
                .copyWith(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class TimeOfDaySelect extends StatefulWidget {
  const TimeOfDaySelect({Key key, this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  _TimeOfDaySelectState createState() => _TimeOfDaySelectState();
}

class _TimeOfDaySelectState extends State<TimeOfDaySelect> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      crossAxisCount: 2,
      mainAxisSpacing: 40,
      crossAxisSpacing: 37,
      controller: widget.controller,
      children: List.generate(
          24,
          (index) =>
              _buildGridItem("${index < 10 ? "0$index" : index}:00", 100)),
    );
  }

  Widget _buildGridItem(String time, int price) {
    return Container(
      width: 145,
      height: 145,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.darkGray.withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            style: TextStyles.airbnbCerealMedium
                .copyWith(fontSize: 24, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "\$$price /",
                  style: TextStyles.airbnbCerealMedium
                      .copyWith(fontSize: 14, color: Colors.black)),
              TextSpan(
                  text: " person",
                  style: TextStyles.airbnbCerealBook.copyWith(
                      fontSize: 12, color: Colors.black.withOpacity(0.6)))
            ]),
          )
        ],
      ),
    );
  }
}

// ........................

class Restaurant {
  final String id;
  final String name;
  final List<int> pricePerHour;

  const Restaurant(this.id, this.name, this.pricePerHour);

  Restaurant book(int hour) {
    if (hour < 0) {
      return null;
    }

    int hourIdx = hour % 24;
    if (pricePerHour[hourIdx] < 0) {
      return null;
    }

    pricePerHour[hourIdx] = -1;

    return Restaurant(id, name, pricePerHour);
  }
}

// class ReservationPage extends StatefulWidget {
//   ReservationPage({Key key}): super(key: key);

//   @override
//   _ReservationPageState createState() => _ReservationPageState();
// }

// class _ReservationPageState extends State<ReservationPage> {
//   const List<Restaurants> _restaurants = [
//     Restaurant("id-1", "Burger King", [-1, -1, -1, -1, -1 -1, 10, 10, 10, 10, 10, -1, -1, -1, -1, -1 -1, 10, 10, 10, 10, 10])
//   ]
// }
