import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:water_delivery/presentation/design/custom_scaffold.dart';
import 'package:water_delivery/presentation/design/widgets/primary_button.dart';
import 'package:water_delivery/presentation/main_flow/main_flow.dart';
import 'package:water_delivery/presentation/register/pages/register/register_page.dart';
import 'package:water_delivery/presentation/register/pages/verify/verify_page.dart';

@RoutePage()
class RegisterFlow extends StatefulWidget {
  const RegisterFlow({super.key});

  @override
  State<RegisterFlow> createState() => _RegisterFlowState();
}

class _RegisterFlowState extends State<RegisterFlow> {
  final _isActiveButtonNotifier = ValueNotifier<bool>(false);
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _phoneNumberNotifier = ValueNotifier<String>('+7');
  final _codeNotifier = ValueNotifier<String>('');
  final _isCorrentCodeNotifier = ValueNotifier<bool?>(null);

  final _phoneController = TextEditingController();
  final _pageController = PageController(initialPage: 0);
  final maskForPhone = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      if (_currentPageNotifier.value == 0) {
        final phone = maskForPhone.getUnmaskedText();
        _isActiveButtonNotifier.value = phone.length >= 10;
      }
    });
    _codeNotifier.addListener(() {
      final value = _codeNotifier.value;
      if (value.isNotEmpty && value.length == 6) {
        if (value == '555555') {
          _isCorrentCodeNotifier.value = true;
          _isActiveButtonNotifier.value = true;
        } else {
          _isCorrentCodeNotifier.value = false;
        }
      } else {
        _isCorrentCodeNotifier.value = null;
        _isActiveButtonNotifier.value = false;
      }
    });
  }

  @override
  void dispose() {
    _isActiveButtonNotifier.dispose();
    _currentPageNotifier.dispose();
    _phoneController.dispose();
    _phoneNumberNotifier.dispose();
    _pageController.dispose();
    _codeNotifier.dispose();
    _isCorrentCodeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) {
                    _currentPageNotifier.value = value;
                  },
                  children: [
                    RegisterPage(
                      controller: _phoneController,
                      formatters: [maskForPhone],
                    ),
                    VerifyPage(
                      onBackTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                        _setDefaultValues();
                      },
                      codeNotifier: _codeNotifier,
                      isCorrentCodeNotifier: _isCorrentCodeNotifier,
                      phoneNumberNotifier: _phoneNumberNotifier,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 45 - viewPadding.bottom,
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, child) => ValueListenableBuilder<bool>(
                    valueListenable: _isActiveButtonNotifier,
                    builder: (context, isActive, child) => CustomPrimaryButton(
                      onTap: () {
                        if (currentPage == 0) {
                          _goToNextPage();
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MainFlow(),
                            ),
                          );
                        }
                      },
                      isActive: isActive,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToNextPage() {
    final phone = maskForPhone.getMaskedText();
    _phoneNumberNotifier.value = '+7 $phone';
    _isActiveButtonNotifier.value = false;
    FocusScope.of(context).requestFocus(FocusNode());
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _setDefaultValues() {
    _codeNotifier.value = '';
    _isCorrentCodeNotifier.value = null;
    _phoneNumberNotifier.value = '';
    _phoneController.text = '';
    _isActiveButtonNotifier.value = false;
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
