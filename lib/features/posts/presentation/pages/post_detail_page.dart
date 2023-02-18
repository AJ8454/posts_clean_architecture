import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/page_detail_widget/page_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PageDetailWidget(post: post),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Post Detail"),
    );
  }
}
