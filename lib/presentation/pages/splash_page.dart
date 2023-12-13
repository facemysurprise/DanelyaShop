import 'package:flutter/material.dart';
import 'package:flutter_nd/presentation/pages/color.dart';
import 'package:flutter_nd/presentation/pages/login_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
  await Future.delayed(Duration(seconds: 3));
  if (mounted) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorColors.color11, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/cosmetica.json',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), 
            Text(
              'Добро пожаловать!',
              style: TextStyle(
                color: ColorColors.primaryColor, 
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}