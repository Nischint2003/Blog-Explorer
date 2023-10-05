import 'package:blog_explorer/model/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class FavouriteBlogsNotifier extends StateNotifier<List<Blog>> {
  FavouriteBlogsNotifier() : super([]);

  // Function to add/remove a blog from favorites
  void addBlogFav(Blog blog) {
    final blogIsFav = state.contains(blog);
    if (blogIsFav) {
      state = state.where((b) => b.id != blog.id).toList();
    } else {
      state = [...state, blog];
    }
    state = [...state];

    // Store favorites locally
    storeFavouritesLocally();
  }

  // Function to store favorites locally
  Future<void> storeFavouritesLocally() async {
    final dbpath = await getDatabasesPath();
    final db = await openDatabase(
      path.join(dbpath, 'favourite_blogs.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favourite_blogs(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
      version: 1,
    );

    // Clear existing data
    await db.delete('favourite_blogs');

    // Insert new data
    for (var blog in state) {
      await db.insert('favourite_blogs', {
        'id': blog.id,
        'title': blog.title,
        'image': blog.imageUrl,
      });
    }
  }

  // Function to load favorites from local storage
  Future<void> loadFavouritesLocally() async {
    final dbpath = await getDatabasesPath();
    final db = await openDatabase(
      path.join(dbpath, 'favourite_blogs.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favourite_blogs(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
      version: 1,
    );

    final data = await db.query('favourite_blogs');
    state = data
        .map(
          (row) => Blog(
            id: row['id'] as String,
            imageUrl: row['image'] as String,
            title: row['title'] as String,
          ),
        )
        .toList();
  }
}

final favouriteBlogsProvider =
    StateNotifierProvider<FavouriteBlogsNotifier, List<Blog>>((ref) {
  final notifier = FavouriteBlogsNotifier();
  // Load favorites from local storage when the provider is created
  notifier.loadFavouritesLocally();
  return notifier;
});
