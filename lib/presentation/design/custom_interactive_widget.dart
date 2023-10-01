import 'package:flutter/material.dart';

class CustomInteractiveWidget extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final double upperBound;
  final bool isZoom;
  final HitTestBehavior behavior;
  const CustomInteractiveWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.upperBound = 0.05,
    this.isZoom = false,
    this.behavior = HitTestBehavior.opaque,
  }) : super(key: key);
  @override
  State<CustomInteractiveWidget> createState() => _CustomInteractiveWidgetState();
}

class _CustomInteractiveWidgetState extends State<CustomInteractiveWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.upperBound > 0) {
      _controller = AnimationController(
        vsync: this,
        reverseDuration: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 150),
        upperBound: widget.upperBound,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller?.reverse();
  }

  void onTapCancel() {
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapCancel: onTapCancel,
      onTapUp: _onTapUp,
      onTap: widget.onTap ?? () {},
      behavior: widget.behavior,
      child: _controller == null
          ? widget.child
          : ValueListenableBuilder<double>(
              valueListenable: _controller!,
              builder: (context, value, child) {
                final scale = widget.isZoom ? 1 + value : 1 - value;
                return Transform.scale(
                  scale: scale,
                  child: widget.child,
                );
              },
            ),
    );
  }
}
