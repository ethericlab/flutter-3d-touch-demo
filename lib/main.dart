import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_3d_touch_sample/components/common.dart';
import './components/index.dart';

void main() => runApp(RestaurantDemo());

class RestaurantDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Flutter 3D Touch demo',
      color: Colors.black,
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
  String _selectedRestaurant = 'Burger King';

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
                  selectedRestaurant: _selectedRestaurant,
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
      _selectedRestaurant = name;
    });
  }
}