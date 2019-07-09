import 'package:flutter/widgets.dart';
import './index.dart';

class BookFragment extends StatelessWidget {
  const BookFragment({Key key, @required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 31,
            bottom: 31,
            left: 40,
            child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '\$',
                      style: TextStyles.airbnbCerealMedium.copyWith(
                          fontSize: 12, color: Colors.black.withOpacity(0.75))),
                  TextSpan(
                      text: price.toStringAsFixed(2),
                      style: TextStyles.airbnbCerealMedium
                          .copyWith(fontSize: 20, color: Colors.black))
                ])),
          ),
          Positioned(
            top: 18,
            bottom: 18,
            right: 24,
            child: TapOpacity(
                onTap: () {},
                child: Container(
                  width: 135,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 24,
                            offset: Offset(0, 8))
                      ]),
                  child: Center(
                      child: Text("Book",
                          style: TextStyles.airbnbCerealMedium
                              .copyWith(fontSize: 16, color: Colors.white))),
                )),
          )
        ],
      ),
    );
  }
}