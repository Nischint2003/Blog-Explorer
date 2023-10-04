import 'package:blog_explorer/model/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteBlogsNotifier extends StateNotifier<List<Blog>> {
  FavouriteBlogsNotifier() : super([]);
  void addBlogFav(Blog blog) {
    final blogIsFav = state.contains(blog);
    if (blogIsFav) {
      state = state.where((b) => b.id != blog.id).toList();
    } else {
      state = [...state, blog];
    }
    state = [...state];
  }
}

final favouriteBlogsProvider =
    StateNotifierProvider<FavouriteBlogsNotifier, List<Blog>>((ref) {
  return FavouriteBlogsNotifier();
});
