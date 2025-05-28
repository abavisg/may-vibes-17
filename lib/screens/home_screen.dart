import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tweenvibes/utils/constants.dart';
import 'package:tweenvibes/utils/routes.dart';
import 'package:tweenvibes/theme/app_theme.dart';
import 'package:tweenvibes/widgets/twin_map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentForecast = Constants.aiForecastMessage;

  // List of possible forecasts
  final List<String> _possibleForecasts = [
    'Most twins are upbeat and positive now.',
    'A wave of creativity is flowing through the community.',
    'Many users are feeling reflective today.',
    'Energy levels seem lower than usual in the community.',
    'An exciting mood shift is happening across timezones.',
    'Emotional balance is trending upward globally.',
    'Watch for strong emotional connections this evening.',
  ];

  @override
  void initState() {
    super.initState();

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

          // Twin Map View (Replacing the 3D Globe)
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              clipBehavior:
                  Clip.antiAlias, // To ensure the map respects rounded corners
              child: const TwinMapView(),
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
}
