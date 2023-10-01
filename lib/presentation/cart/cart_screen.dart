import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:water_delivery/presentation/cart/widgets/closed_widget.dart';
import 'package:water_delivery/presentation/cart/widgets/opened_widget.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';
import 'package:water_delivery/presentation/design/custom_scaffold.dart';
import 'package:water_delivery/presentation/design/widgets/primary_button.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 18 + viewPadding.top),
                const _Header(),
                const SizedBox(height: 18),
                const Expanded(
                  child: _ProductsGrid(),
                ),
              ],
            ),
            Positioned(
              bottom: 45,
              left: 0,
              right: 0,
              child: CustomPrimaryButton(
                onTap: () {},
                text: 'Оформить заказ',
                isActive: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatefulWidget {
  const _ProductsGrid();

  @override
  State<_ProductsGrid> createState() => __ProductsGridState();
}

class __ProductsGridState extends State<_ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      mainAxisSpacing: 9,
      crossAxisSpacing: 9,
      crossAxisCount: 2,
      childAspectRatio: 0.72,
      children: [
        ...List.generate(
          4,
          (index) => AnimationConfiguration.staggeredGrid(
            position: index,
            delay: const Duration(milliseconds: 150),
            duration: const Duration(milliseconds: 300),
            columnCount: 2,
            child: const FadeInAnimation(
              child: SlideAnimation(
                verticalOffset: 30,
                child: _ProductItem(),
              ),
            ),
          ),
        ).toList(),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: CustomColors.primaryButtonBg,
      middleColor: CustomColors.primaryButtonBg,
      closedElevation: 0,
      openElevation: 0,
      closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
      openBuilder: (context, action) => const OpenedWidget(),
      closedBuilder: (context, action) => const ClosedWidget(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Вода питьевая',
                  style: TextStyle(
                    fontSize: 20,
                    height: 25 / 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomInteractiveWidget(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF808080).withOpacity(0.3),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
