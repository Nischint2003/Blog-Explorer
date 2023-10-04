import 'package:blog_explorer/model/blog.dart';
import 'package:blog_explorer/service/favouriteservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class BlogDetailScreen extends ConsumerStatefulWidget {
  const BlogDetailScreen({super.key, required this.blog});
  final Blog blog;

  @override
  ConsumerState<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends ConsumerState<BlogDetailScreen> {
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final favNotifier = ref.read(favouriteBlogsProvider.notifier);

    if (isLiked) {
      // Remove the blog from favorites
      favNotifier.addBlogFav(widget.blog);
    } else {
      // Add the blog to favorites
      favNotifier.addBlogFav(widget.blog);
    }

    // Return the opposite of the current liked status
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          LikeButton(
            isLiked: ref.watch(favouriteBlogsProvider).contains(widget.blog),
            onTap: onLikeButtonTapped,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.blog.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'TITLE : ${widget.blog.title}',
                style: GoogleFonts.ubuntu(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
