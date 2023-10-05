import 'package:blog_explorer/blogdetails.dart';
import 'package:blog_explorer/model/blog.dart';
import 'package:blog_explorer/service/blogservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({super.key});

  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  final localBlogProvider = FutureProvider<List<Blog>>((ref) async {
    return loadBlogsLocally();
  });

  @override
  void initState() {
    super.initState();
    // Trigger the loading of blogs from the local database
    ref.read(localBlogProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Explorer'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 21, 50, 210),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Blog>>(
        // Use the localBlogProvider instead of blogProvider
        future: ref.read(localBlogProvider.future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No blogs available.'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final blog = data[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(
                          blog: blog,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            blog.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            blog.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
