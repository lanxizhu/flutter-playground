// lib/features/home/pages/home_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playground/features/home/widgets/banner_swiper.dart';

import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final List<String> _items = [];

  int _page = 1;
  final int _pageSize = 10;

  bool _isLoading = false;
  bool _hasMore = true;

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    // 页面初始化时加载数据
    // context.read<HomeProvider>().fetchHomeData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 模拟接口请求
      await Future.delayed(const Duration(seconds: 1));

      final newItems = List.generate(
        _pageSize,
        (index) => '第 $_page 页 - Item ${index + 1}',
      );

      setState(() {
        _items.addAll(newItems);
        _page++;

        // 这里根据接口返回判断是否还有更多
        if (newItems.length < _pageSize) {
          _hasMore = false;
        }

        // 示例：加载到第 5 页后停止
        if (_page > 5) {
          _hasMore = false;
        }

        print(" 加载了第 ${_page - 1} 页数据，当前总条数: ${_items.length}");
      });
    } catch (e) {
      debugPrint('加载失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    _page = 1;
    _hasMore = true;
    _items.clear();
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,

        // edgeOffset: MediaQuery.of(context).padding.top,
        displacement: MediaQuery.of(context).padding.top,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
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
                      '推荐内容${Platform.isIOS ? ' (iOS)' : ' (Android)'}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),

                    // 这里可以放从 Provider 获取的 Banners 列表
                    BannerSwiper(),
                  ],
                ),
              ),
            ),

            // 商品网格示例
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 0,
                bottom: 16,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ItemCard(title: _items[index]),
                  childCount: _items.length,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;

  const ItemCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorScheme.of(context).primaryContainer,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: ColorScheme.of(context).onPrimaryContainer,
            fontSize: TextTheme.of(context).bodyLarge?.fontSize,
          ),
        ),
      ),
    );
  }
}
