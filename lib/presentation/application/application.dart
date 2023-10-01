import 'package:flutter/material.dart';
import 'package:water_delivery/presentation/register/register_flow.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterFlow(),
    );
  }
}
