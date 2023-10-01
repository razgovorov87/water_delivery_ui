import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';

import '../../../generated/assets.gen.dart';

class ClosedWidget extends StatelessWidget {
  const ClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
        depth: 0,
        shape: NeumorphicShape.flat,
        intensity: 1,
        surfaceIntensity: 0.8,
        color: CustomColors.primaryButtonBg.withOpacity(0.3),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowLightColorEmboss: Colors.white.withOpacity(0.2),
        shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Assets.waterBottle.image(),
            ),
            const SizedBox(height: 9),
            const Text(
              'Вода "Вкус жизни" с селеном 19л',
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 18 / 13,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              '240 \u20BD',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                height: 20 / 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 9),
            const _CounterWidget(),
          ],
        ),
      ),
    );
  }
}

class _CounterWidget extends StatefulWidget {
  const _CounterWidget();

  @override
  State<_CounterWidget> createState() => __CounterWidgetState();
}

class __CounterWidgetState extends State<_CounterWidget> {
  final _countNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _countNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _countNotifier,
      builder: (context, count, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: count == 0
            ? Expanded(
                child: _NeumorphicWrapper(
                  child: CustomInteractiveWidget(
                    onTap: () {
                      _countNotifier.value = 1;
                    },
                    child: Container(
                      height: 32,
                      alignment: Alignment.center,
                      child: const Text(
                        'В корзину',
                        style: TextStyle(
                          fontSize: 11,
                          height: 13 / 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  _NeumorphicWrapper(
                    child: InkWell(
                      onTap: () {
                        _countNotifier.value -= 1;
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$count шт.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 18 / 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _NeumorphicWrapper(
                    child: InkWell(
                      onTap: () {
                        _countNotifier.value += 1;
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _NeumorphicWrapper extends StatelessWidget {
  const _NeumorphicWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        depth: 0,
        shape: NeumorphicShape.flat,
        intensity: 1,
        surfaceIntensity: 0.8,
        color: Colors.white.withOpacity(0.2),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowLightColorEmboss: Colors.white.withOpacity(0.2),
        shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
      ),
      child: child,
    );
  }
}
