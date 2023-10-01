import 'package:flutter/material.dart';
import 'package:water_delivery/generated/assets.gen.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.bottomNavigation,
  });

  final Widget body;
  final Widget? bottomNavigation;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.bg.image(
            fit: BoxFit.cover,
          ),
          body,
          if (bottomNavigation != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: viewPadding.bottom,
              child: bottomNavigation!,
            ),
        ],
      ),
    );
  }
}
