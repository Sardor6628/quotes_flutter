import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_flutter/constants/image_path.dart';
import 'package:quotes_flutter/presentation/quote_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    Timer(const Duration(seconds: 3), () => Get.offAll(() => QuotePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
                child: Image.asset(ImagePath.logo,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                ))));
  }
}
