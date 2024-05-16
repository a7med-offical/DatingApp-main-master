import 'dart:async';
import 'package:dating_app/features/auth/persentation/view/register_view.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({
    super.key,
  });

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: unused_field
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    AnimationFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animationController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/images/splash_icon.png', height: 150, width: 200),
            const Text(
              'Dating App',
              style: TextStyle(color: Colors.purple,fontSize: 24,fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  void AnimationFunction() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterView(),
          ));
    });
  }
}