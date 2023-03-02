import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/modules/comment/comment_page.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/modules/common/test_subroute_page.dart';
import 'package:flutter_dmzj/modules/index/index_controller.dart';
import 'package:flutter_dmzj/modules/index/index_page.dart';
import 'package:flutter_dmzj/modules/news/detail/news_detail_page.dart';
import 'package:flutter_dmzj/modules/user/user_home_controller.dart';
import 'package:flutter_dmzj/routes/route_path.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const kIndex = RoutePath.kIndex;
  static final routes = [
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexPage(),
      bindings: [
        BindingsBuilder.put(
          () => IndexController(),
        ),
        BindingsBuilder.put(
          () => ComicHomeController(),
        ),
        BindingsBuilder.put(
          () => UserHomeController(),
        ),
      ],
    ),
  ];

  /// 定义子路由
  static Route<dynamic>? generateSubRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return GetPageRoute(
          settings: settings,
          page: () => const EmptyPage(),
        );
      case RoutePath.kTestSubRoute:
        return GetPageRoute(
          settings: settings,
          transition: Transition.native,
          page: () => const TestSubRoutePage(),
        );
      case RoutePath.kNewsDetail:
        var parameter = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          page: () => NewsDetailPage(
            title: parameter["title"],
            newsUrl: parameter["newsUrl"],
            newsId: parameter["newsId"],
          ),
        );
      case RoutePath.kComment:
        var parameter = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          page: () => CommentPage(
            objId: parameter["objId"],
            type: parameter["type"],
          ),
        );
      default:
        return GetPageRoute(page: () => const EmptyPage());
    }
  }
}
