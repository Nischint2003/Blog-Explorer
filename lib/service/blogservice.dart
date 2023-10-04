import 'dart:convert';
import 'package:blog_explorer/model/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
    return jsonData.map((blog) => Blog.fromJson(blog)).toList();
  } else {
    // Throw an error if the request fails
    throw Exception('Failed to load blogs');
  }
});
