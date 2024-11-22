import 'package:flutter/material.dart';
import 'dart:math';

/// A highly customizable button widget with particle and scaling animations.
///
/// `CSButton` combines a particle burst animation with a scaling effect to create
/// an interactive and visually appealing button. This is ideal for use in apps
/// where engaging user interaction is a priority, such as social media or games.
class CSButton extends StatefulWidget {
  /// Creates a `CSButton`.
  ///
  /// The button displays an icon, and on tap, it triggers both particle and
  /// scale animations alongside invoking the provided `onTap` callback.
  ///
  /// * [icon] specifies the button's icon.
  /// * [iconSize] defines the size of the button's icon.
  /// * [color] sets the color for both the icon and the particle effect.
  /// * [onTap] is the callback executed when the button is tapped.
  const CSButton({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.onTap,
  });

  /// The icon displayed within the button.
  final IconData? icon;

  /// The size of the icon in the button.
  final double? iconSize;

  /// The color applied to the icon and particle effects.
  final Color? color;

  /// The callback executed when the button is tapped.
  final VoidCallback onTap;

  @override
  State<CSButton> createState() => _CSButtonState();
}

class _CSButtonState extends State<CSButton> with TickerProviderStateMixin {
  late AnimationController _controller; // Manages the particle animation.
  late AnimationController _scaleController; // Manages the scale animation.
  late Animation<double> _scaleAnimation; // Defines the scaling effect.
  late List<Particle> _particles; // Holds the particle data for rendering.

  @override
  void initState() {
    super.initState();

    // Initialize the particle animation controller with a 1-second duration.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });

    // Initialize the scale animation controller with a 200ms duration.
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Define the scaling effect using a Tween animation.
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    // Initialize an empty list of particles.
    _particles = [];
  }

  /// Handles tap events, triggering both particle and scale animations.
  void _onTap() {
    // Generate a new set of particles for the animation.
    _particles = List.generate(10, (index) => Particle());
    _controller.reset();
    _controller.forward();

    // Start the scale animation and reverse it after completion.
    _scaleController.forward().then((_) => _scaleController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Respond to user taps by triggering animations and invoking the callback.
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
            // Render the particle effects using a custom painter.
            CustomPaint(
              size: const Size(24.0, 24.0),
              painter: ParticlePainter(
                particles: _particles,
                particleColor: widget.color!,
                progress: _controller.value,
              ),
            ),
            // Display the button's icon with a scaling effect.
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
    // Dispose of the animation controllers to free resources.
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}

/// Represents a single particle in the animation.
///
/// Particles are randomly generated with attributes like position, size,
/// speed, and direction to create a dynamic and natural effect.
class Particle {
  final double x; // X-coordinate of the particle.
  final double y; // Y-coordinate of the particle.
  final double size; // Size of the particle.
  final double speed; // Speed of the particle.
  final double angle; // Movement angle of the particle.

  /// Creates a `Particle` with random attributes for natural variation.
  Particle()
      : x = 0,
        y = 0,
        size = Random().nextDouble() * 5 + 1,
        speed = Random().nextDouble() * 3.5 + 1,
        angle = Random().nextDouble() * 2 * pi;
}

/// A custom painter that renders particles based on the animation progress.
///
/// The `ParticlePainter` calculates the position and size of each particle
/// during the animation and renders them on the canvas.
class ParticlePainter extends CustomPainter {
  final List<Particle> particles; // List of particles to render.
  final double progress; // Animation progress (0.0 to 1.0).
  final Color particleColor; // Base color of the particles.

  /// Creates a `ParticlePainter` with the given particles and animation progress.
  ParticlePainter({
    required this.particles,
    required this.progress,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Configure the paint with the particle color and fading effect.
    final Paint paint = Paint()..color = particleColor.withOpacity(1 - progress);

    // Draw each particle on the canvas.
    for (var particle in particles) {
      final double dx = size.width / 2 + cos(particle.angle) * particle.speed * progress * 15;
      final double dy = size.height / 2 + sin(particle.angle) * particle.speed * progress * 15;

      // Render the particle as a fading circle.
      canvas.drawCircle(Offset(dx, dy), particle.size * (1 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
