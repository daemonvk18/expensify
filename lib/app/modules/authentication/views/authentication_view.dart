import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          //leave some space
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          //logo and text
          SvgPicture.asset("assets/images/expensify_logo.svg")
        ],
      ),
    );
  }
}
