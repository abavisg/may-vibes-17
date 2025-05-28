import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

class TwinMapView extends StatefulWidget {
  const TwinMapView({super.key});

  @override
  State<TwinMapView> createState() => _TwinMapViewState();
}

class _TwinMapViewState extends State<TwinMapView> {
  final MapController _mapController = MapController();

  // Mock twin data
  final List<TwinUser> _twins = [
    TwinUser(
      name: 'Emma',
      initials: 'EM',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      location: LatLng(40.7128, -74.0060), // New York
      moodScore: 8,
      moodEmoji: '😄',
      journalEntry: 'Had a fantastic day exploring Central Park!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    TwinUser(
      name: 'John',
      initials: 'JD',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      location: LatLng(51.5074, -0.1278), // London
      moodScore: 5,
      moodEmoji: '😐',
      journalEntry: 'Work was okay, but looking forward to the weekend.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    TwinUser(
      name: 'Sophia',
      initials: 'SL',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      location: LatLng(35.6762, 139.6503), // Tokyo
      moodScore: 9,
      moodEmoji: '🤩',
      journalEntry: 'Just landed my dream job! So excited!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    TwinUser(
      name: 'Miguel',
      initials: 'MR',
      avatarUrl: 'https://i.pravatar.cc/150?img=7',
      location: LatLng(-33.8688, 151.2093), // Sydney
      moodScore: 2,
      moodEmoji: '😔',
      journalEntry: 'Feeling down today. Need some self-care time.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    TwinUser(
      name: 'Zara',
      initials: 'ZK',
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      location: LatLng(19.4326, -99.1332), // Mexico City
      moodScore: 7,
      moodEmoji: '😊',
      journalEntry: 'Visited a beautiful museum today!',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    TwinUser(
      name: 'David',
      initials: 'DT',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      location: LatLng(48.8566, 2.3522), // Paris
      moodScore: 6,
      moodEmoji: '🙂',
      journalEntry: 'Trying out a new café. Their croissants are decent.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    TwinUser(
      name: 'Aisha',
      initials: 'AA',
      avatarUrl: 'https://i.pravatar.cc/150?img=13',
      location: LatLng(1.3521, 103.8198), // Singapore
      moodScore: 10,
      moodEmoji: '🥳',
      journalEntry: 'Just got engaged! Happiest day of my life!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    TwinUser(
      name: 'Leo',
      initials: 'LF',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
      location: LatLng(-22.9068, -43.1729), // Rio de Janeiro
      moodScore: 1,
      moodEmoji: '😢',
      journalEntry: 'Got some bad news today. Need some time to process.',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    TwinUser(
      name: 'Nina',
      initials: 'NP',
      avatarUrl: 'https://i.pravatar.cc/150?img=17',
      location: LatLng(55.7558, 37.6173), // Moscow
      moodScore: 4,
      moodEmoji: '😕',
      journalEntry: 'Feeling a bit stressed about my upcoming exams.',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
    ),
  ];

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(20, 0), // Center of the world map
        initialZoom: 2,
        minZoom: 1,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.twinvibes.app',
        ),
        MarkerLayer(
          markers: _buildMarkers(),
        ),
      ],
    );
  }

  List<Marker> _buildMarkers() {
    return _twins.map((twin) {
      // Determine color based on mood score
      Color moodColor;
      if (twin.moodScore <= 3) {
        moodColor = Colors.red.shade400; // Low mood
      } else if (twin.moodScore <= 6) {
        moodColor = Colors.amber.shade400; // Neutral mood
      } else {
        moodColor = Colors.green.shade400; // High mood
      }

      return Marker(
        width: 60,
        height: 60,
        point: twin.location,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => _showTwinDetails(twin),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: moodColor.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              backgroundImage:
                  twin.avatarUrl != null ? NetworkImage(twin.avatarUrl!) : null,
              child: twin.avatarUrl == null
                  ? Text(
                      twin.initials,
                      style: TextStyle(
                        color: moodColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      );
    }).toList();
  }

  void _showTwinDetails(TwinUser twin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: twin.avatarUrl != null
                                ? NetworkImage(twin.avatarUrl!)
                                : null,
                            child: twin.avatarUrl == null
                                ? Text(
                                    twin.initials,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  twin.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  _formatTimestamp(twin.timestamp),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoCard(
                            'Mood',
                            twin.moodScore.toString(),
                            _getMoodColor(twin.moodScore),
                          ),
                          _buildInfoCard(
                            'Feeling',
                            twin.moodEmoji,
                            Colors.grey.shade100,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Journal Entry',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          twin.journalEntry,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard(String label, String value, Color backgroundColor,
      {double fontSize = 16}) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(int moodScore) {
    if (moodScore <= 3) {
      return Colors.red.shade100;
    } else if (moodScore <= 6) {
      return Colors.amber.shade100;
    } else {
      return Colors.green.shade100;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

class TwinUser {
  final String name;
  final String initials;
  final String? avatarUrl;
  final LatLng location;
  final int moodScore; // 0-10
  final String moodEmoji;
  final String journalEntry;
  final DateTime timestamp;

  TwinUser({
    required this.name,
    required this.initials,
    this.avatarUrl,
    required this.location,
    required this.moodScore,
    required this.moodEmoji,
    required this.journalEntry,
    required this.timestamp,
  });
}
