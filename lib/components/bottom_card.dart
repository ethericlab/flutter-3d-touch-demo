import 'package:flutter/widgets.dart';
import './index.dart';

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