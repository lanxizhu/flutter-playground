// lib/features/home/pages/home_page.dart
import 'package:flutter/material.dart';

import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print('HomePage constructor called');

    // 页面初始化时加载数据
    // context.read<HomeProvider>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 顶部的 App Bar 或 Header
          const HomeHeader(),

          // 内容区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '推荐内容',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  // 这里可以放从 Provider 获取的 Banners 列表
                ],
              ),
            ),
          ),

          // 商品网格示例
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.blueGrey[100],
                child: Card(child: Center(child: Text('商品 $index'))),
              ),

              childCount: 10,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom),
          ),
        ],
      ),
    );
  }
}
