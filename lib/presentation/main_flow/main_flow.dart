import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:water_delivery/generated/assets.gen.dart';
import 'package:water_delivery/presentation/cart/cart_screen.dart';
import 'package:water_delivery/presentation/design/custom_bottom_navigation.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';
import 'package:water_delivery/presentation/design/custom_scaffold.dart';

@RoutePage()
class MainFlow extends StatefulWidget {
  const MainFlow({super.key});

  @override
  State<MainFlow> createState() => _MainFlowState();
}

class _MainFlowState extends State<MainFlow> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigation: const CustomBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Каталог',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  height: 34 / 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 48),
              _CategoryItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                text: 'Вода питьевая',
                image: Assets.waterBottle.image(height: 90),
              ),
              const SizedBox(height: 44),
              _CategoryItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                text: 'Оборудование',
                image: Assets.equipment.image(height: 90),
              ),
              const SizedBox(height: 27),
              const _HistoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryWidget extends StatelessWidget {
  const _HistoryWidget();

  @override
  Widget build(BuildContext context) {
    const itemTextStyle = TextStyle(
      fontSize: 11,
      height: 13 / 11,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontStyle: FontStyle.italic,
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF94A6E3),
            Color(0xFF2C70B5),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Заказывал ранее',
                  style: TextStyle(
                    fontSize: 16,
                    height: 21 / 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomInteractiveWidget(
                onTap: () {},
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Повторить',
                    style: itemTextStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Вода питьевая без добавок 19л',
                  style: itemTextStyle,
                ),
              ),
              Text(
                '1 шт. 240 \u20BD',
                style: itemTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Итого: 240 \u20BD',
                style: itemTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.onTap,
    required this.text,
    required this.image,
  });

  final VoidCallback onTap;
  final String text;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return CustomInteractiveWidget(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 76,
            padding: const EdgeInsets.fromLTRB(84, 18, 18, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF94A6E3),
                  Color(0xFF2C70B5),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 25 / 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 19,
            bottom: 10,
            child: Hero(
              tag: 'image',
              child: image,
            ),
          ),
        ],
      ),
    );
  }
}
