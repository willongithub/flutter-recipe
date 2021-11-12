import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  // 1
  final List<Post> friendPosts;

  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      // 3
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 4
          Text('Social Chefs 👩‍🍳',
              style: Theme.of(context).textTheme.headline1),
          // 5
          const SizedBox(height: 16),
          // 1
          ListView.separated(
            // 2 让Flutter知道这是一个nested的子view。
            primary: false,
            // 3 将这一层的滑动关掉。
            // physics: const NeverScrollableScrollPhysics(),
            // 4 锁定列表长度。
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              // 5
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              // 6
              return const SizedBox(height: 16);
            },
          ),

          // 6
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
