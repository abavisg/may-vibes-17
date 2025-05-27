import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tweenvibes/utils/constants.dart';
import 'package:tweenvibes/utils/routes.dart';
import 'package:tweenvibes/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _currentForecast = Constants.aiForecastMessage;

  // List of possible AI forecasts
  final List<String> _possibleForecasts = [
    'Most twins are upbeat and positive now.',
    'A wave of creativity is flowing through the community.',
    'Many users are feeling reflective today.',
    'Energy levels seem lower than usual in the community.',
    'An exciting mood shift is happening across timezones.',
    'Emotional balance is trending upward globally.',
    'Watch for strong emotional connections this evening.',
  ];

  // Mock data for mood avatars around the globe
  final List<MoodAvatar> _moodAvatars = [
    MoodAvatar(
        emoji: '😊',
        position: 0.2,
        longitude: -100,
        latitude: 40,
        mood: 'happy'),
    MoodAvatar(
        emoji: '😀',
        position: 0.4,
        longitude: -70,
        latitude: -20,
        mood: 'happy'),
    MoodAvatar(
        emoji: '🙂',
        position: 0.6,
        longitude: 30,
        latitude: 55,
        mood: 'neutral'),
    MoodAvatar(
        emoji: '😐',
        position: 0.1,
        longitude: 120,
        latitude: 35,
        mood: 'neutral'),
    MoodAvatar(
        emoji: '😔', position: 0.7, longitude: 45, latitude: -30, mood: 'sad'),
    MoodAvatar(
        emoji: '😢', position: 0.8, longitude: -20, latitude: -40, mood: 'sad'),
    MoodAvatar(
        emoji: '😡',
        position: 0.95,
        longitude: 90,
        latitude: -10,
        mood: 'angry'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 60), // Slower rotation for better effect
    )..repeat();

    // Generate new forecast when the screen opens
    _generateNewForecast();

    // Setup timer to refresh forecast every 30 minutes
    Future.delayed(Duration.zero, () {
      _setupForecastTimer();
    });
  }

  void _setupForecastTimer() {
    Future.delayed(const Duration(minutes: 30), () {
      if (mounted) {
        _generateNewForecast();
        _setupForecastTimer(); // Schedule next update
      }
    });
  }

  void _generateNewForecast() {
    if (mounted) {
      setState(() {
        // Choose a random forecast from the list
        final random = math.Random();
        String newForecast;
        do {
          newForecast =
              _possibleForecasts[random.nextInt(_possibleForecasts.length)];
        } while (
            newForecast == _currentForecast && _possibleForecasts.length > 1);

        _currentForecast = newForecast;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF1FA), // Light lavender background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
        title: const Text(
          Constants.appName,
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primaryColor),
            onPressed: () => AppRoutes.navigateToSettings(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Forecast Banner - Now positioned directly below the app bar
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.insights,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          Constants.aiForecastTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _currentForecast,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Refresh button
                  GestureDetector(
                    onTap: _generateNewForecast,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.refresh,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3D Globe with Mood Avatars
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated rotating globe
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationController.value * 2 * math.pi,
                        child: Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [
                                Color(0xFF4A80F0), // Lighter blue
                                Color(0xFF1A3D8C), // Darker blue
                              ],
                              stops: [0.4, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4A80F0).withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          // World map overlay with continents
                          child: CustomPaint(
                            painter: GlobePainter(),
                            size: const Size(280, 280),
                          ),
                        ),
                      );
                    },
                  ),

                  // Mood avatars overlaid on globe
                  ..._buildMoodAvatars(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRoutes.navigateToMoodEntry(context),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> _buildMoodAvatars() {
    return _moodAvatars.map((avatar) {
      // Calculate position using trigonometry to place on the "surface" of the globe
      final double angle = _animationController.value * 2 * math.pi;

      // Adjust longitude based on rotation
      final double adjustedLongitude =
          avatar.longitude + (angle * 180 / math.pi);

      // Convert to radians
      final double longitudeRad = adjustedLongitude * math.pi / 180;
      final double latitudeRad = avatar.latitude * math.pi / 180;

      // Calculate visibility based on longitude (to hide avatars on the back side of the globe)
      final bool isVisible = (adjustedLongitude + 180) % 360 <= 180;
      final double opacity = isVisible ? 1.0 : 0.0;

      // Calculate position relative to globe center
      final double x = math.cos(latitudeRad) * math.sin(longitudeRad);
      final double radius = 130; // Slightly smaller than globe radius

      // Map 3D coordinates to 2D screen position
      final double xPos = x * radius;
      final double yPos =
          -math.sin(latitudeRad) * radius; // Negative for screen coordinates

      Color glowColor;
      switch (avatar.mood) {
        case 'happy':
          glowColor = const Color(0xFF4CAF50); // Green
          break;
        case 'neutral':
          glowColor = const Color(0xFFFFC107); // Amber
          break;
        case 'sad':
          glowColor = const Color(0xFFFF9800); // Orange
          break;
        case 'angry':
          glowColor = const Color(0xFFF44336); // Red
          break;
        default:
          glowColor = const Color(0xFFFFC107);
      }

      return Positioned(
        left: 140 + xPos,
        top: 140 + yPos,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                avatar.emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Custom painter for globe continents
class GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Paint for continents
    final continentPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Simplified continent shapes (approximations)

    // North America
    final northAmerica = Path()
      ..moveTo(center.dx - radius * 0.5, center.dy - radius * 0.2)
      ..lineTo(center.dx - radius * 0.25, center.dy - radius * 0.45)
      ..lineTo(center.dx - radius * 0.1, center.dy - radius * 0.1)
      ..lineTo(center.dx - radius * 0.3, center.dy + radius * 0.1)
      ..close();
    canvas.drawPath(northAmerica, continentPaint);

    // South America
    final southAmerica = Path()
      ..moveTo(center.dx - radius * 0.25, center.dy + radius * 0.1)
      ..lineTo(center.dx - radius * 0.15, center.dy + radius * 0.45)
      ..lineTo(center.dx - radius * 0.3, center.dy + radius * 0.4)
      ..lineTo(center.dx - radius * 0.35, center.dy + radius * 0.15)
      ..close();
    canvas.drawPath(southAmerica, continentPaint);

    // Europe
    final europe = Path()
      ..moveTo(center.dx + radius * 0.05, center.dy - radius * 0.3)
      ..lineTo(center.dx + radius * 0.2, center.dy - radius * 0.25)
      ..lineTo(center.dx + radius * 0.15, center.dy - radius * 0.05)
      ..lineTo(center.dx - radius * 0.05, center.dy - radius * 0.1)
      ..close();
    canvas.drawPath(europe, continentPaint);

    // Africa
    final africa = Path()
      ..moveTo(center.dx + radius * 0.1, center.dy - radius * 0.05)
      ..lineTo(center.dx + radius * 0.3, center.dy - radius * 0.1)
      ..lineTo(center.dx + radius * 0.35, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.1, center.dy + radius * 0.35)
      ..lineTo(center.dx + radius * 0.05, center.dy + radius * 0.1)
      ..close();
    canvas.drawPath(africa, continentPaint);

    // Asia
    final asia = Path()
      ..moveTo(center.dx + radius * 0.2, center.dy - radius * 0.25)
      ..lineTo(center.dx + radius * 0.5, center.dy - radius * 0.2)
      ..lineTo(center.dx + radius * 0.45, center.dy + radius * 0.1)
      ..lineTo(center.dx + radius * 0.3, center.dy + radius * 0.15)
      ..lineTo(center.dx + radius * 0.2, center.dy - radius * 0.05)
      ..close();
    canvas.drawPath(asia, continentPaint);

    // Australia
    final australia = Path()
      ..moveTo(center.dx + radius * 0.45, center.dy + radius * 0.2)
      ..lineTo(center.dx + radius * 0.6, center.dy + radius * 0.15)
      ..lineTo(center.dx + radius * 0.55, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.4, center.dy + radius * 0.35)
      ..close();
    canvas.drawPath(australia, continentPaint);

    // Draw latitude/longitude grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Equator
    canvas.drawCircle(center, radius * 0.8, gridPaint);

    // Other latitude lines
    canvas.drawCircle(center, radius * 0.4, gridPaint);
    canvas.drawCircle(center, radius * 0.6, gridPaint);

    // Longitude lines
    canvas.drawLine(Offset(center.dx, center.dy - radius),
        Offset(center.dx, center.dy + radius), gridPaint);

    canvas.drawLine(Offset(center.dx - radius, center.dy),
        Offset(center.dx + radius, center.dy), gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Class to store mood avatar data
class MoodAvatar {
  final String emoji;
  final double position; // Position in animation cycle (0.0 - 1.0)
  final double longitude; // -180 to 180
  final double latitude; // -90 to 90
  final String mood; // 'happy', 'neutral', 'sad', 'angry'

  MoodAvatar({
    required this.emoji,
    required this.position,
    required this.longitude,
    required this.latitude,
    required this.mood,
  });
}
