import 'package:flutter/widgets.dart';
import './index.dart';

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