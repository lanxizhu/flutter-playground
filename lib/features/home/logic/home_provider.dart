import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<String> _banners = [];
  List<String> get banners => _banners;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();

    // 模拟从你的 Go 后端获取数据
    await Future.delayed(const Duration(seconds: 2));
    _banners = ['活动海报 1', '活动海报 2', '活动海报 3'];

    _isLoading = false;
    notifyListeners();
  }
}
