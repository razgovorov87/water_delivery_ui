import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:water_delivery/generated/assets.gen.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';
import 'package:water_delivery/presentation/design/custom_scaffold.dart';
import 'package:water_delivery/presentation/design/widgets/primary_button.dart';

class OpenedWidget extends StatefulWidget {
  const OpenedWidget({super.key});

  @override
  State<OpenedWidget> createState() => _OpenedWidgetState();
}

class _OpenedWidgetState extends State<OpenedWidget> {
  final _activeTabNotifier = ValueNotifier<String>('about');
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _activeTabNotifier.addListener(() {
      int newIndex = 0;
      switch (_activeTabNotifier.value) {
        case 'about':
          newIndex = 0;
        case 'compound':
          newIndex = 1;
        case 'howToOrder':
          newIndex = 2;
      }
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Header(),
                  const SizedBox(height: 18),
                  const _Slider(),
                  const SizedBox(height: 18),
                  const Text(
                    'Вода "Вкус жизни" 19л',
                    style: TextStyle(
                      fontSize: 20,
                      height: 25 / 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SegmentWidget(
                    activeTabNotifer: _activeTabNotifier,
                  ),
                  const SizedBox(height: 30),
                  ExpandablePageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      _PageViewItem(),
                      _PageViewItem(),
                      _PageViewItem(),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomPrimaryButton(
                  onTap: () {},
                  isActive: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageViewItem extends StatelessWidget {
  const _PageViewItem();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 15,
      height: 20 / 15,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Вода станет отличным проводником на пути к здоровью и хорошему самочувствию. В чем польза такой воды?',
          style: textStyle,
        ),
        Text(''),
        Text(
          'При ежедневном употреблении вода улучшает общее самочувствие, позволяет легче переносить физические нагрузки. Может служить основой для приготовления напитков и блюд.',
          style: textStyle,
        ),
      ],
    );
  }
}

class _SegmentWidget extends StatefulWidget {
  const _SegmentWidget({
    required this.activeTabNotifer,
  });

  final ValueNotifier<String> activeTabNotifer;

  @override
  State<_SegmentWidget> createState() => __SegmentWidgetState();
}

class __SegmentWidgetState extends State<_SegmentWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: AdvancedSegment(
        controller: widget.activeTabNotifer,
        borderRadius: BorderRadius.circular(20),
        sliderOffset: 4,
        backgroundColor: CustomColors.primaryButtonBg.withOpacity(0.4),
        sliderColor: Colors.white.withOpacity(0.4),
        activeStyle: const TextStyle(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        inactiveStyle: TextStyle(
          fontSize: 16,
          height: 21 / 16,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.7),
        ),
        shadow: const [],
        segments: const {
          'about': 'О товаре',
          'compound': 'Состав',
          'howToOrder': 'Как заказать',
        },
      ),
    );
  }
}

class _Slider extends StatefulWidget {
  const _Slider();

  @override
  State<_Slider> createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  final _activeSliderNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _activeSliderNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 240,
          child: CarouselSlider(
            items: [
              ...List.generate(
                3,
                (index) => Assets.waterBottle.image(),
              ),
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                _activeSliderNotifier.value = index;
              },
            ),
          ),
        ),
        const SizedBox(height: 18),
        ValueListenableBuilder<int>(
          valueListenable: _activeSliderNotifier,
          builder: (context, activeIndex, child) => AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: 3,
            effect: WormEffect(
              offset: 3,
              dotHeight: 7,
              dotWidth: 7,
              dotColor: Colors.black.withOpacity(0.2),
              activeDotColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomInteractiveWidget(
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
        const Spacer(),
        const _HeaderIcon(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 9),
        const _HeaderIcon(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.icon,
  });

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 0.6,
        shape: NeumorphicShape.flat,
        intensity: 1,
        boxShape: const NeumorphicBoxShape.circle(),
        surfaceIntensity: 0.8,
        color: CustomColors.primaryButtonBg.withOpacity(0.1),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        shadowLightColorEmboss: Colors.white.withOpacity(0.2),
        shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
      ),
      child: Container(
        height: 42,
        width: 42,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
