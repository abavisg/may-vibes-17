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
    10: '🥳',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title with Emoji
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mood, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        Constants.appName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Mood Question
                Text(
                  Constants.moodQuestionLabel,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 30),

                // Mood Slider and Value
                Row(
                  children: [
                    const Text('0'),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppTheme.primaryColor,
                          inactiveTrackColor: Colors.grey.shade300,
                          thumbColor: AppTheme.primaryColor,
                          trackHeight: 6.0,
                        ),
                        child: Slider(
                          value: _moodValue,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          onChanged: _updateMoodEmoji,
                        ),
                      ),
                    ),
                    const Text('10'),
                  ],
                ),

                const SizedBox(height: 20),

                // Selected Emoji Display
                Center(
                  child: Column(
                    children: [
                      Text(
                        Constants.chooseEmojiLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedEmoji,
                        style: const TextStyle(fontSize: 60),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Journal Entry
                Text(
                  Constants.journalEntryLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: ElevatedButton(
                    onPressed: () {
                      // In a real app, save the mood entry to a database
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    child: const Text(Constants.shareMoodButton),
                  ),
                ),

                const SizedBox(height: 20),

                // Copyright
                Center(
                  child: Text(
                    Constants.copyright,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
