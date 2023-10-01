import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:water_delivery/presentation/design/custom_colors.dart';
import 'package:water_delivery/presentation/design/custom_interactive_widget.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({
    super.key,
    required this.phoneNumberNotifier,
    required this.onBackTap,
    required this.codeNotifier,
    required this.isCorrentCodeNotifier,
  });

  final ValueNotifier<String> phoneNumberNotifier;
  final VoidCallback onBackTap;
  final ValueNotifier<String> codeNotifier;
  final ValueNotifier<bool?> isCorrentCodeNotifier;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _VerifyBody(
          onBackTap: onBackTap,
          viewPadding: viewPadding,
          phoneNumberNotifier: phoneNumberNotifier,
          codeNotifier: codeNotifier,
          isCorrectCodeNotifier: isCorrentCodeNotifier,
        ),
      ),
    );
  }
}

class _VerifyBody extends StatelessWidget {
  const _VerifyBody({
    required this.viewPadding,
    required this.onBackTap,
    required this.phoneNumberNotifier,
    required this.codeNotifier,
    required this.isCorrectCodeNotifier,
  });

  final EdgeInsets viewPadding;
  final VoidCallback onBackTap;
  final ValueNotifier<String> phoneNumberNotifier;
  final ValueNotifier<String> codeNotifier;
  final ValueNotifier<bool?> isCorrectCodeNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 18 + viewPadding.top),
          Row(
            children: [
              CustomInteractiveWidget(
                onTap: onBackTap,
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
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Введите\nкод из СМС',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 41 / 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 9),
          ValueListenableBuilder<String>(
            valueListenable: phoneNumberNotifier,
            builder: (context, phoneNumber, child) => RichText(
              text: TextSpan(
                text: 'Код отправлен на ',
                style: const TextStyle(
                  fontSize: 16,
                  height: 21 / 16,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          _CodeFieldsWidget(
            codeNotifier: codeNotifier,
            isCorrectCodeNotifier: isCorrectCodeNotifier,
          ),
          const SizedBox(height: 47),
          const _TimerWidget(),
        ],
      ),
    );
  }
}

class _TimerWidget extends StatefulWidget {
  const _TimerWidget();

  @override
  State<_TimerWidget> createState() => __TimerWidgetState();
}

class __TimerWidgetState extends State<_TimerWidget> {
  final _timerNotifier = ValueNotifier<int>(15);
  final _canStartAgainNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> _startTimer() async {
    int timer = 15;
    while (timer != 0) {
      _timerNotifier.value = timer;
      timer--;
      await Future.delayed(const Duration(seconds: 1));
    }

    _canStartAgainNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _canStartAgainNotifier,
      builder: (context, isCanStart, child) => ValueListenableBuilder<int>(
        valueListenable: _timerNotifier,
        builder: (context, timer, child) => CustomInteractiveWidget(
          onTap: isCanStart
              ? () {
                  _canStartAgainNotifier.value = false;
                  _startTimer();
                }
              : () {},
          child: RichText(
            text: TextSpan(
              text: 'Отправить код еще раз ',
              style: TextStyle(
                fontSize: 17,
                height: 22 / 17,
                color: isCanStart ? Colors.white : Colors.grey.shade800,
              ),
              children: [
                if (!isCanStart)
                  TextSpan(
                    text: '($timer)',
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeFieldsWidget extends StatefulWidget {
  const _CodeFieldsWidget({
    required this.codeNotifier,
    required this.isCorrectCodeNotifier,
  });

  final ValueNotifier<String> codeNotifier;
  final ValueNotifier<bool?> isCorrectCodeNotifier;

  @override
  State<_CodeFieldsWidget> createState() => __CodeFieldsWidgetState();
}

class __CodeFieldsWidgetState extends State<_CodeFieldsWidget> {
  final List<TextEditingController> _controllers = [
    ...List.generate(
      6,
      (index) => TextEditingController(),
    ).toList(),
  ];

  final List<FocusNode> _focusNodes = [
    ...List.generate(
      6,
      (index) => FocusNode(),
    ).toList(),
  ];

  @override
  void initState() {
    super.initState();
    _controllers.last.addListener(() {
      final lastController = _controllers.last;
      if (lastController.value.text.isNotEmpty) {
        final code = _controllers.map((e) => e.text).join();
        widget.codeNotifier.value = code;
      } else {
        widget.codeNotifier.value = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: widget.isCorrectCodeNotifier,
      builder: (context, isCorrect, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ..._controllers
              .mapIndexed(
                (index, controller) => _CodeFieldItem(
                  index: index,
                  controller: controller,
                  focusNode: _focusNodes[index],
                  isCorrect: isCorrect,
                  nodes: _focusNodes,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _CodeFieldItem extends StatefulWidget {
  const _CodeFieldItem({
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.nodes,
    this.isCorrect,
  });

  final int index;
  final TextEditingController controller;
  final bool? isCorrect;
  final FocusNode focusNode;
  final List<FocusNode> nodes;

  @override
  State<_CodeFieldItem> createState() => _CodeFieldItemState();
}

class _CodeFieldItemState extends State<_CodeFieldItem> {
  final _isFocusedNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _isFocusedNotifier.value = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
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
      child: ValueListenableBuilder<bool>(
        valueListenable: _isFocusedNotifier,
        builder: (context, isFocus, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: widget.isCorrect == null
                  ? isFocus
                      ? Colors.white
                      : Colors.transparent
                  : widget.isCorrect!
                      ? Colors.greenAccent
                      : Colors.redAccent,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.length == 1 && widget.index != 5) {
                FocusScope.of(context).requestFocus(widget.nodes[widget.index + 1]);
              } else if (value.isEmpty && widget.index != 0) {
                FocusScope.of(context).requestFocus(widget.nodes[widget.index - 1]);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              height: 22 / 17,
            ),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
