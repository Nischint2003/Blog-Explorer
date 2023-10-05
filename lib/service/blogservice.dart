import 'dart:convert';
import 'package:blog_explorer/model/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, 'blogs.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE blogs_explorer(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
  }, version: 1);
  return db;
}

Future<List<Blog>> loadBlogsLocally() async {
  final db = await _getDatabase();
  final data = await db.query('blogs_explorer');
  return data
      .map(
        (row) => Blog(
          id: row['id'] as String,
          imageUrl: row['image'] as String,
          title: row['title'] as String,
        ),
      )
      .toList();
}

final blogProvider = FutureProvider<List<Blog>>((ref) async {
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  final response = await http.get(Uri.parse(url), headers: {
    'x-hasura-admin-secret': adminSecret,
  });

  if (response.statusCode == 200) {
    // Parse the response data and return a list of blogs
    final List<dynamic> jsonData = json.decode(response.body)['blogs'];
    List<Blog> blogs = jsonData.map((blog) => Blog.fromJson(blog)).toList();

    // Store blogs locally
    final db = await _getDatabase();
    for (var blog in blogs) {
      await db.insert('blogs_explorer', {
        'id': blog.id,
        'title': blog.title,
        'image': blog.imageUrl,
      });
    }

    return blogs;
  } else {
    // Throw an error if the request fails
    throw Exception('Failed to load blogs');
  }
});
