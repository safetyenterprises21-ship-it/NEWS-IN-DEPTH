import 'package:flutter/material.dart';

void main() {
  runApp(const NewsInDepthApp());
}

class NewsInDepthApp extends StatelessWidget {
  const NewsInDepthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News In Depth',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News In Depth"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          NewsCard(
            category: "Economy",
            title: "India Semiconductor Mission",
            summary:
                "Government expands incentives for semiconductor manufacturing.",
          ),
          NewsCard(
            category: "Environment",
            title: "Monsoon Outlook 2026",
            summary:
                "IMD predicts above-normal rainfall across most regions.",
          ),
          NewsCard(
            category: "International Relations",
            title: "India-EU Trade Talks",
            summary:
                "Negotiations continue on market access and tariffs.",
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String category;
  final String title;
  final String summary;

  const NewsCard({
    super.key,
    required this.category,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(label: Text(category)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(summary),
          ],
        ),
      ),
    );
  }
}