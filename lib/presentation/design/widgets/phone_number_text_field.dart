import 'package:flutter/services.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({
    super.key,
    required this.controller,
    this.formatters,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 0,
            intensity: 1,
            surfaceIntensity: 0.8,
            color: CustomColors.primaryButtonBg.withOpacity(0.4),
            lightSource: LightSource.topLeft,
            shadowLightColor: Colors.white,
            shadowLightColorEmboss: Colors.white.withOpacity(0.2),
            shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
          ),
          child: Container(
            height: 44,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              '+7',
              style: TextStyle(
                fontSize: 17,
                height: 22 / 17,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 0,
              intensity: 1,
              surfaceIntensity: 0.8,
              color: CustomColors.primaryButtonBg.withOpacity(0.4),
              lightSource: LightSource.topLeft,
              shadowLightColor: Colors.white,
              shadowLightColorEmboss: Colors.white.withOpacity(0.2),
              shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
            ),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: widget.controller,
                inputFormatters: widget.formatters,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '987 654 32 10',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    height: 22 / 17,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
