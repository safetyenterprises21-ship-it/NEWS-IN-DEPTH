import 'package:share_plus/share_plus.dart';
import 'bookmark_page.dart';
import 'services/bookmark_service.dart';
import 'search_page.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/article.dart';

void main() {
  runApp(const UPSCNewsApp());
}

class UPSCNewsApp extends StatelessWidget {
  const UPSCNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UPSC Current Affairs',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const NewsFeedPage(),
    );
  }
}

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() =>
      _NewsFeedPageState();
}

class _NewsFeedPageState
    extends State<NewsFeedPage> {

  String selectedCategory = 'All';

  Future<List<Article>> loadArticles() async {
  final String response =
      await rootBundle.loadString('assets/articles.json');

  final List<dynamic> data = json.decode(response);

  return data
      .map((item) => Article.fromJson(item))
      .toList();
}
 Widget _categoryChip(String text) {
  final bool isSelected =
      selectedCategory == text;

  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.25)
              : Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {return Scaffold(
  drawer: Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          child: Text(
            'UPSC Current Affairs',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ListTile(
  leading: const Icon(Icons.bookmark),
  title: const Text('Bookmarks'),
  onTap: () {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BookmarkPage(),
      ),
    );
  },
),


        ListTile(
  leading: const Icon(Icons.info),
  title: const Text('About'),
  onTap: () {
    showAboutDialog(
      context: context,
      applicationName: 'UPSC Current Affairs',
      applicationVersion: '1.0.0',
      applicationLegalese:
          'Made for UPSC Aspirants',
    );
  },
),
      ],
    ),
  ),

  body: FutureBuilder<List<Article>>(
        future: loadArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final articles = snapshot.data ?? [];

final categories = [
  'All',
  ...articles
      .map((e) => e.category ?? '')
      .where((e) => e.isNotEmpty)
      .toSet(),
];
final filteredArticles =
    selectedCategory == 'All'
        ? articles
        : articles.where((article) {
            return article.category ==
                selectedCategory;
          }).toList();
if (articles.isEmpty) {
  return const Center(
    child: Text('No articles found'),
  );
}

          if (articles.isEmpty) {
            return const Center(
              child: Text('No articles found'),
            );
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: filteredArticles.length,
            itemBuilder: (context, index) {
              final article = filteredArticles[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    article.image ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 60,
                          ),
                        ),
                      );
                    },
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),

                  

     
                  Positioned(
  top: 50,
  left: 10,
  right: 10,
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [

        CircleAvatar(
  radius: 18,
  backgroundColor: Colors.black54,
  child: Builder(
    builder: (context) => IconButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 18,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
  ),
),
        const SizedBox(width: 10),

  ...categories.map(
  (category) => _categoryChip(category),
),

const SizedBox(width: 10),

CircleAvatar(
  radius: 18,
  backgroundColor: Colors.black54,
  child: IconButton(
    icon: const Icon(
      Icons.search,
      color: Colors.white,
      size: 18,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchPage(
            articles: articles,
          ),
        ),
      );
    },
  ),
),
      ],
    ),
  ),
),
                        SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
  children: [
    Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        article.category ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    const Spacer(),

    IconButton(
      onPressed: () async {
        await BookmarkService.addBookmark(
          article.title,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${article.title} bookmarked',
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.bookmark_border,
        color: Colors.white70,
        size: 18,
      ),
    ),

    IconButton(
      onPressed: () {
        Share.share(
          'Shared from UPSC Current Affairs App\n\n'
          '${article.title}\n\n'
          '${article.summary}',
        );
      },
      icon: const Icon(
        Icons.share,
        color: Colors.white70,
        size: 18,
      ),
    ),
  ],
),

const SizedBox(height: 15),

                          Text(
                            article.title ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            article.summary ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 25),

                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                        title:
                                           article.title ?? "No Title",
                                        detail:
                                            article.detail ?? "No Details",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Read in Depth",
                                ),
                              ),

                              const SizedBox(width: 10),

                        
                            ],
                          ),

                          const SizedBox(height: 20),

                          const Center(
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white70,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String detail;

  const DetailPage({
    super.key,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In-Depth Analysis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              detail,
              style: const TextStyle(
                fontSize: 16,
                height: 1.8,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}