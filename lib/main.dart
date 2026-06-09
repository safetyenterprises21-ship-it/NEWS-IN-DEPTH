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
      home: const NewsFeedScreen(),
    );
  }
}

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        "category": "Economy",
        "title": "India Semiconductor Mission",
        "content":
            "The Government of India has expanded incentives for semiconductor manufacturing. This move aims to reduce import dependence, strengthen supply chains, and create a domestic chip ecosystem."
      },
      {
        "category": "Environment",
        "title": "Monsoon Outlook 2026",
        "content":
            "The India Meteorological Department predicts above-normal rainfall across most regions. This could support agricultural output but may also increase flood risks in vulnerable areas."
      },
      {
        "category": "International Relations",
        "title": "India–EU Trade Talks",
        "content":
            "India and the European Union continue negotiations on tariffs, market access, and investment rules. A successful agreement could significantly increase bilateral trade."
      },
    ];

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(article["category"]!),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    article["title"]!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        article["content"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}