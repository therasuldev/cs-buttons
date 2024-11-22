import 'package:flutter/material.dart';
import 'dart:math';

class CSButton extends StatefulWidget {
  const CSButton({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.onTap,
  });

  final IconData? icon;
  final double? iconSize;
  final Color? color;
  final VoidCallback onTap;

  @override
  State<CSButton> createState() => _CSButtonState();
}

class _CSButtonState extends State<CSButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();

    // Particle animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });

    // Scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    _particles = [];
  }

  void _onTap() {
    _particles = List.generate(10, (index) => Particle());
    _controller.reset();
    _controller.forward();

    // Trigger the scale animation
    _scaleController.forward().then((_) => _scaleController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
        widget.onTap();
      },
      child: SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Particles
            CustomPaint(
              size: const Size(24.0, 24.0),
              painter: ParticlePainter(
                particles: _particles,
                particleColor: widget.color!,
                progress: _controller.value,
              ),
            ),
            // Heart Icon with scale effect
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.icon,
                size: widget.iconSize,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double angle;

  Particle()
      : x = 0,
        y = 0,
        size = Random().nextDouble() * 5 + 1,
        speed = Random().nextDouble() * 3.5 + 1,
        angle = Random().nextDouble() * 2 * pi;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  final Color particleColor;

  ParticlePainter({
    required this.particles,
    required this.progress,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = particleColor.withOpacity(1 - progress);

    for (var particle in particles) {
      final double dx = size.width / 2 + cos(particle.angle) * particle.speed * progress * 15;
      final double dy = size.height / 2 + sin(particle.angle) * particle.speed * progress * 15;

      canvas.drawCircle(Offset(dx, dy), particle.size * (1 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
