import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'models/article.dart';
import 'services/bookmark_service.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  Future<List<Article>> loadArticles() async {
    final String response =
        await rootBundle.loadString('assets/articles.json');

    final List<dynamic> data = json.decode(response);

    return data
        .map((item) => Article.fromJson(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: FutureBuilder<List<String>>(
        future: BookmarkService.getBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final bookmarks = snapshot.data!;

          if (bookmarks.isEmpty) {
            return const Center(
              child: Text("No bookmarks yet"),
            );
          }

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              return FutureBuilder<List<Article>>(
                future: loadArticles(),
                builder: (context, articleSnapshot) {
                  if (!articleSnapshot.hasData) {
                    return const SizedBox();
                  }

                  final articles = articleSnapshot.data!;

                  final article = articles.firstWhere(
                    (a) => a.title == bookmarks[index],
                  );

                  return ListTile(
                    title: Text(bookmarks[index]),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            title: article.title,
                            detail: article.detail,
                          ),
                        ),
                      );
                    },

                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await BookmarkService.removeBookmark(
                          bookmarks[index],
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookmarkPage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}