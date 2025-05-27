import 'package:flutter/material.dart';
import 'package:tweenvibes/utils/constants.dart';
import 'package:tweenvibes/utils/routes.dart';
import 'package:tweenvibes/theme/app_theme.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  double _moodValue = 5;
  String _selectedEmoji = '😐';
  final TextEditingController _journalController = TextEditingController();

  // Map mood values to emojis
  final Map<double, String> _moodEmojis = {
    0: '😭',
    1: '😢',
    2: '😔',
    3: '😕',
    4: '😐',
    5: '🙂',
    6: '😊',
    7: '😄',
    8: '😁',
    9: '🤩',
    10: '🥳'
  };

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  // Update emoji based on slider value
  void _updateMoodEmoji(double value) {
    setState(() {
      _moodValue = value;
      _selectedEmoji = _moodEmojis[value.round()] ?? '😐';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'How are you feeling?',
          style: TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Emoji Display (Larger and centered)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    _selectedEmoji,
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Mood Slider
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sad',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'Happy',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8.0,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 12),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 20),
                    ),
                    child: Slider(
                      value: _moodValue,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      onChanged: _updateMoodEmoji,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('0'),
                      const Text('5'),
                      const Text('10'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Journal Entry
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Constants.journalEntryLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: _journalController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: Constants.journalPlaceholder,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Share Mood Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // In a real app, save the mood entry to a database
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    Constants.shareMoodButton,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
}
