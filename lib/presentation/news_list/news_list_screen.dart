import 'package:flutter/material.dart';
import 'package:news_potal/presentation/common/app_scaffold.dart';
import 'package:news_potal/presentation/news_list/widgets/app_bar.dart';
import 'package:news_potal/presentation/news_list/widgets/hot_topic.dart';
import 'package:news_potal/presentation/news_list/widgets/latest_news.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NewsListAppBar(),
      child: Column(
        spacing: 25,
        children: [HotTopic(), Expanded(child: LatestNews())],
      ),
    );
  }
}
