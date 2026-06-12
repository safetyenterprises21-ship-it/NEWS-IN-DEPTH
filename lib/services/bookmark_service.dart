import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String key = 'bookmarks';

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }

  static Future<void> addBookmark(String title) async {
    final prefs = await SharedPreferences.getInstance();

    final bookmarks = prefs.getStringList(key) ?? [];

    if (!bookmarks.contains(title)) {
      bookmarks.add(title);
      await prefs.setStringList(key, bookmarks);
    }
  }

  static Future<void> removeBookmark(String title) async {
    final prefs = await SharedPreferences.getInstance();

    final bookmarks = prefs.getStringList(key) ?? [];

    bookmarks.remove(title);

    await prefs.setStringList(key, bookmarks);
  }

  static Future<bool> isBookmarked(String title) async {
    final prefs = await SharedPreferences.getInstance();

    final bookmarks = prefs.getStringList(key) ?? [];

    return bookmarks.contains(title);
  }
}