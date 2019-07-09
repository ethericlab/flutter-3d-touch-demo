import 'package:flutter/widgets.dart';
import './index.dart';

typedef RestaurantSelectCallback(String restaurant);

class RestaurantSelect extends StatelessWidget {
  RestaurantSelect({Key key, this.onSelect, this.selectedRestaurant})
      : super(key: key);

  final RestaurantSelectCallback onSelect;
  final String selectedRestaurant;

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
          height: 30,
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
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _restaurantNames.length,
        separatorBuilder: (BuildContext context, _) => SizedBox(
          width: 16,
        ),
        padding: EdgeInsets.only(left: 24, top: 20),
        itemBuilder: (BuildContext context, int index) => _buildRestaurantItem(
            _restaurantImages[index], _restaurantNames[index]),
      ),
    );
  }

  Widget _buildRestaurantItem(String image, String name) {
    final isSelected = selectedRestaurant == name;

    return TapOpacity(
        onTap: () => onSelect(name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: isSelected
                  ? Matrix4.translationValues(0, -20, 0)
                  : Matrix4.identity(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(height: 120, width: 90, image: AssetImage(image)),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(name,
                style: TextStyles.airbnbCerealBook.copyWith(fontSize: 12))
          ],
        ));
  }
}