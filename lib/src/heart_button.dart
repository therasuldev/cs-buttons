import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'dart:math';

/// A customizable like button widget that allows for a heart animation when double-tapped.
class CSHeartButton extends StatefulWidget {
  const CSHeartButton({
    super.key,
    required this.child,
    this.iconSize = 60.0,
    this.color = Colors.red,
    required this.onDoubleTap,
  });

  /// The child widget to be displayed, typically the button or element you want to attach the like effect to.
  final Widget child;

  /// The size of the heart icon. Default is 60.0.
  final double? iconSize;

  /// The color of the heart icon. Default is red.
  final Color? color;

  /// Callback function to be called when a double tap is detected on the widget.
  final void Function()? onDoubleTap;

  @override
  State<CSHeartButton> createState() => _CSHeartButtonState();
}

class _CSHeartButtonState extends State<CSHeartButton> with TickerProviderStateMixin {
  // List to hold the floating heart animations
  final List<Widget> _floatingHearts = [];

  // Random generator to introduce randomness in animations like position and size
  final Random _random = Random();

  // Counter to assign unique keys to each floating heart icon
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detect double tap on the widget to trigger the heart animation
      onDoubleTapDown: (details) {
        // Capture the tap position
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        _addHeart(localPosition);

        widget.onDoubleTap.call();
      },
      child: Stack(
        children: [widget.child, ..._floatingHearts],
      ),
    );
  }

  /// Adds a new heart icon at a specified position with a unique animation.
  void _addHeart(Offset position) {
    final uniqueKey = _counter++; // Unique key for each floating heart
    final heart = _buildHeart(uniqueKey, position);
    setState(() => _floatingHearts.add(heart));

    // Remove the heart after 2 seconds to avoid cluttering the screen
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _floatingHearts.removeWhere((widget) => widget.key == ValueKey(uniqueKey));
      });
    });
  }

  /// Builds a heart widget with random size and position offset based on tap position.
  Widget _buildHeart(int uniqueKey, Offset position) {
    final size = widget.iconSize! + _random.nextDouble() * 10.0;
    final xOffset = _random.nextDouble() * 2 - 1; // Randomize horizontal direction

    return Positioned(
      key: ValueKey(uniqueKey),
      top: position.dy,
      left: position.dx,
      child: _FloatingHeart(
        size: size,
        xOffset: xOffset,
        color: widget.color!,
      ),
    );
  }
}

/// A widget representing a floating heart with animations for opacity, position, rotation, and scale.
class _FloatingHeart extends StatefulWidget {
  const _FloatingHeart({
    required this.size,
    required this.xOffset,
    required this.color,
  });

  /// The size of the heart icon.
  final double size;

  /// The color of the heart icon.
  final Color color;

  /// The horizontal offset (randomized) to control the direction the heart moves in.
  final double xOffset;

  @override
  State<_FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<_FloatingHeart> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _positionController;
  late AnimationController _rotationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _rotationAnimation;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Fade animation setup to make the heart fade out as it moves
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Position animation setup to move the heart diagonally with a random offset
    _positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.xOffset * 0.5, -1.0),
    ).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    // Rotation animation setup to add slight rotation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    final randomRotation = (widget.xOffset > 0 ? 1 : -1) * (0.05 + _random.nextDouble() * 0.1);
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: randomRotation,
    ).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );

    // Start all animations simultaneously when initialized
    _fadeController.forward();
    _positionController.forward();
    _rotationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _positionAnimation,
        child: RotationTransition(
          turns: _rotationAnimation,
          child: Icon(
            Icons.favorite,
            color: widget.color,
            size: widget.size,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _positionController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
