import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/pages/color.dart';

class CosmeticsAnimationPage extends StatefulWidget {
  @override
  _CosmeticsAnimationPageState createState() => _CosmeticsAnimationPageState();
}

class _CosmeticsAnimationPageState extends State<CosmeticsAnimationPage> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _opacityAnimations;
  late List<Animation<double>> _sizeAnimations;

  final List<String> _cosmeticsInfo = [
    'Lipstick',
    'Eye Shadow',
    'Mascara',
    'Blush',
    'Foundation'
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (index) => AnimationController(
        duration: Duration(milliseconds: 500 + index * 300), vsync: this));
    _opacityAnimations = _controllers.map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(controller)).toList();
    _sizeAnimations = _controllers.map((controller) => Tween<double>(begin: 0.0, end: 50.0).animate(controller)).toList();

    Timer(Duration(milliseconds: 500), () {
      _controllers.forEach((controller) => controller.forward());
    });
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Animated_Cosmetics.tr()),
        backgroundColor: ColorColors.color12,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_opacityAnimations.length, (index) {
              return AnimatedBuilder(
                animation: _controllers[index],
                builder: (context, child) {
                  return Tooltip(
                    message: _cosmeticsInfo[index],
                    child: Opacity(
                      opacity: _opacityAnimations[index].value,
                      child: Container(
                        width: _sizeAnimations[index].value,
                        height: _sizeAnimations[index].value,
                        decoration: BoxDecoration(
                          color: Colors.primaries[index % Colors.primaries.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}