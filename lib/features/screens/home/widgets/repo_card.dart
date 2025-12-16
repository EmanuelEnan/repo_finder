import 'package:flutter/material.dart';

class RepoCard extends StatelessWidget {
  final String name;
  final String owner;
  final String starCount;
  final String? updatedAt;

  const RepoCard({
    super.key,
    required this.name,
    required this.owner,
    required this.starCount,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Repo name: $name'),
          Text('Owner type: $owner'),
          Text('Star count: $starCount'),
          Text('Updated at: $updatedAt'),
        ],
      ),
    );
  }
}
