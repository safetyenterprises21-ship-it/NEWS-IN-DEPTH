import 'main.dart';
import 'models/article.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<Article> articles;

  const SearchPage({
    super.key,
    required this.articles,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final results = widget.articles.where((article) {
  final q = query.toLowerCase();

  return article.title
              .toLowerCase()
              .contains(q) ||
         article.summary
              .toLowerCase()
              .contains(q) ||
         article.category
              .toLowerCase()
              .contains(q);
}).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Articles"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search UPSC topics...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
  return Card(
  child: ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        results[index].image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(results[index].title),
    subtitle: Text(results[index].category),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPage(
            title: results[index].title,
            detail: results[index].detail,
          ),
        ),
      );
    },
  ),
);
              },
            ),
          ),
        ],
      ),
    );
  }
}