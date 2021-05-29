import 'package:catter_app/config/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget transitionButton({
  @required dynamic tapAction,
  @required Icon transitionIcon,
  @required String myProfileText,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: tapAction,
    child: ConstrainedBox(
      constraints: const BoxConstraints.expand(height: 65),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 1,
          color: CustomColors.whiteMain,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(0),
          ),
        ),
        child: Container(
          color: CustomColors.whiteMain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  transitionIcon,
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$myProfileText',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.brownMain,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 25,
                    color: CustomColors.brownMain,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
