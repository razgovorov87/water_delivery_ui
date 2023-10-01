import 'package:flutter/material.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.onTap,
    this.isActive = false,
    this.text = 'Продолжить',
  });

  final bool isActive;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomInteractiveWidget(
      onTap: isActive ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              if (isActive) ...[
                const Color(0xFF815483),
                CustomColors.primaryButtonBg,
              ] else ...[
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
              ],
            ],
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              color: isActive ? Colors.black.withOpacity(0.25) : Colors.transparent,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            height: 22 / 17,
            fontWeight: FontWeight.w600,
            color: isActive ? CustomColors.lightText : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
