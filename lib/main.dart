import 'dart:async';
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
  bool _isTimeCardOpen = false;

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
              children: <Widget>[
                RestaurantSelect(
                  onSelect: _handleRestaurantSelect,
                ),
                BottomCard(
                  isOpen: _isTimeCardOpen,
                  onToggle: _toggleTimeCard,
                  child: TimeSelect(
                    onCardToggle: _toggleTimeCard,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _toggleTimeCard() => setState(() => _isTimeCardOpen = !_isTimeCardOpen);

  _handleRestaurantSelect(String name) {
    setState(() {
      _isTimeCardOpen = true;
    });
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

typedef RestaurantSelectCallback(String restaurant);

class RestaurantSelect extends StatelessWidget {
  RestaurantSelect({Key key, this.onSelect}) : super(key: key);

  final RestaurantSelectCallback onSelect;

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
    return TapOpacity(
      onTap: () => onSelect(name),
      child: Column(
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
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({Key key, this.child, this.isOpen, this.onToggle})
      : super(key: key);

  final Widget child;
  final bool isOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      transform:
          isOpen ? Matrix4.identity() : Matrix4.translationValues(0, 315, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34), topRight: Radius.circular(34)),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

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

  void handlePageChange(int page) {
    print('changing page to $page');
    setState(() {
      _selectedDayPeriod = _pageIndexToPeriod(page);
    });
  }

  void handlePeriodSelect(DayPeriod period) {
    _pageController.animateToPage(_periodToPageIndex(period),
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut)
    .whenComplete(() {
      setState(() => _selectedDayPeriod = period);
    });
  }

  void handleTimeSelect(int hour) {
    setState(() {
      _selectedHour = _selectedHour == hour ? null : hour;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DayPeriodSelect(
          selectedPeriod: _selectedDayPeriod,
          onSelect: handlePeriodSelect,
          onCardToggle: widget.onCardToggle,
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: handlePageChange,
            children: <Widget>[
              TimeOfDayPage(
                forPeriod: DayPeriod.morning,
                onSelect: handleTimeSelect,
                selectedHour: _selectedHour,
              ),
              TimeOfDayPage(
                forPeriod: DayPeriod.day,
                onSelect: handleTimeSelect,
                selectedHour: _selectedHour,
              ),
              TimeOfDayPage(
                forPeriod: DayPeriod.evening,
                onSelect: handleTimeSelect,
                selectedHour: _selectedHour,
              ),
            ],
          ),
        )
      ],
    );
  }
}

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
      {Key key, this.onSelect, this.selectedPeriod = DayPeriod.morning, this.onCardToggle})
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
                border:
                Border(bottom: BorderSide(color: Colors.gray.withOpacity(0.2)))),
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

class TapOpacity extends StatefulWidget {
  TapOpacity(
      {@required this.onTap,
      @required this.child,
      this.disabled = false,
      this.opacity = 1,
      this.tapOpacity = 0.5,
      this.duration = const Duration(milliseconds: 300),
      this.curve = Curves.easeInOut});

  final Widget child;
  final GestureTapCallback onTap;
  final Curve curve;
  final double opacity;
  final double tapOpacity;
  final Duration duration;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _TapOpacityState();
}

class _TapOpacityState extends State<TapOpacity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _opacity;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, value: 1, lowerBound: 0, upperBound: 1);
    _opacity = Tween<double>(begin: widget.tapOpacity, end: widget.opacity)
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: !widget.disabled ? widget.onTap : null,
      onTapDown: (_) => _animateTapDown(),
      onTapUp: (_) => _animateTapUp(),
      onTapCancel: () => _animateTapUp(),
      child: _AnimatedTapOpacity(
        animation: _opacity,
        child: widget.child,
      ));

  _animateTapDown() {
    _controller.duration = Duration(milliseconds: 50);
    _controller.reverse();
  }

  _animateTapUp() {
    _controller.duration = widget.duration;
    if (_controller.status != AnimationStatus.completed) {
      Timer(Duration(milliseconds: 200), () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }
}

class _AnimatedTapOpacity extends AnimatedWidget {
  _AnimatedTapOpacity({Key key, this.animation, this.child})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: child,
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
