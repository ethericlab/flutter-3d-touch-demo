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
          Stack(
            children: <Widget>[RestaurantSelect()],
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
