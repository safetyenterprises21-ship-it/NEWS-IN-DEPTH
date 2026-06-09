import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final String title;
  final String summary;

  const ArticleScreen({
    super.key,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          summary,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}