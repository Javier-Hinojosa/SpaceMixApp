import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spacemix/core/app_theme.dart';
import 'package:spacemix/core/routing/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Navigate to Home after delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.router.replace(const HomeRoute());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Render the local image mapped in pubspec.yaml
                Image.asset(
                  'assets/images/icon.png',
                  width: 250, // Matches the heart-beat pulse size
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback visually if asset isn't dropped locally yet
                    return const Icon(
                      Icons.graphic_eq,
                      size: 150,
                      color: AppTheme.primary,
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
