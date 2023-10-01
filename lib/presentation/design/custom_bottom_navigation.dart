import 'package:flutter_svg/flutter_svg.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:water_delivery/generated/assets.gen.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final _activeNavItemNotifier = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 1,
        shape: NeumorphicShape.flat,
        intensity: 1,
        surfaceIntensity: 0.8,
        color: CustomColors.primaryButtonBg.withOpacity(0.2),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowLightColorEmboss: Colors.white.withOpacity(0.2),
        shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
      ),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        child: ValueListenableBuilder<int>(
          valueListenable: _activeNavItemNotifier,
          builder: (context, activeItem, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                onTap: () {
                  _activeNavItemNotifier.value = 0;
                },
                icon: Assets.icons.home.svg(),
                isActive: activeItem == 0,
              ),
              _NavItem(
                onTap: () {
                  _activeNavItemNotifier.value = 1;
                },
                icon: Assets.icons.evaGrid.svg(),
                isActive: activeItem == 1,
              ),
              _NavItem(
                onTap: () {
                  _activeNavItemNotifier.value = 2;
                },
                icon: Assets.icons.money.svg(),
                isActive: activeItem == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.onTap,
    required this.icon,
    this.isActive = false,
  });

  final VoidCallback onTap;
  final SvgPicture icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 250),
        width: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: isActive ? Colors.white.withOpacity(0.3) : Colors.transparent,
        ),
        child: icon,
      ),
    );
  }
}
