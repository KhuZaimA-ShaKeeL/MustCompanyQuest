import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mustcompanyy/Account%20setup/emailPage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _positionAnimation;

  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool startScale = false;
  bool showLoadingText = false;
  bool showProgressIndicator = false;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _colorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.blue,
    ).animate(CurvedAnimation(parent: _colorController, curve: Curves.linear));

    _positionAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.decelerate),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 50,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.linear));

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showLoadingText = true;
        });

        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            showProgressIndicator = true;
          });
          if (showProgressIndicator) {
            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => emailPage()),

              );

            });
          }
        });
      }
    });

    _bounceController.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 3100), () {
      _bounceController.stop();
      setState(() {
        startScale = true;
      });
      _scaleController.forward();
      _colorController.forward();
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _scaleController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: showLoadingText ? Colors.blue : Colors.white,
          ),
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _positionAnimation,
                _scaleAnimation,
                _colorAnimation,
              ]),
              builder: (context, child) {
                final offsetY = startScale ? 0.0 : _positionAnimation.value;
                final scale = startScale ? _scaleAnimation.value : 1.0;

                return Transform.translate(
                  offset: Offset(0, offsetY),
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _colorAnimation.value ?? Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (showLoadingText) ...[
            if (showProgressIndicator)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: showProgressIndicator ? 1 : 0,
                  duration: Duration(milliseconds: 600),
                  child: Text(
                    'Welcome to CoinPay',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
