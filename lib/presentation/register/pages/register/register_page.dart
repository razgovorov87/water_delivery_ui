import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_delivery/presentation/design/widgets/phone_number_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.controller,
    this.formatters,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _RegisterBody(
          viewPadding: viewPadding,
          controller: widget.controller,
          formatters: widget.formatters,
        ),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({
    required this.viewPadding,
    required this.controller,
    this.formatters,
  });

  final EdgeInsets viewPadding;
  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 128 - viewPadding.top,
          ),
          const Text(
            'Введите\nномер телефона',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 41 / 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 49),
          PhoneNumberTextField(
            controller: controller,
            formatters: formatters,
          ),
        ],
      ),
    );
  }
}
