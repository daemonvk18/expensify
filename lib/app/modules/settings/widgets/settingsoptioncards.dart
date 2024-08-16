import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SettingOptions extends StatelessWidget {
  const SettingOptions(
      {super.key,
      required this.imageUrl,
      required this.optionName,
      required this.onTap});
  final String imageUrl;
  final String optionName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.02,
          vertical: screenSize.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //two rows
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //option icon
              SvgPicture.asset(imageUrl),
              SizedBox(
                width: screenSize.height * 0.02,
              ),
              //option name
              Text(optionName)
            ],
          ),
          //right button
          GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset("assets/images/right_arrow.svg"))
        ],
      ),
    );
  }
}
