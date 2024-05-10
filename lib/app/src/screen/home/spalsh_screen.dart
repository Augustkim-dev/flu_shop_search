import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).popAndPushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Splash Screen'),
      ),
    );
  }
}
