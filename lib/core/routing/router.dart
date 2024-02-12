import 'package:flutter/material.dart';
import 'package:mvvm_task_demo/core/models/user_list_response_model.dart';
import 'package:mvvm_task_demo/core/routing/routes.dart';
import 'package:mvvm_task_demo/ui/views/detail_view.dart';
import 'package:mvvm_task_demo/ui/views/home_view.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return pageRoute(HomeView(), settings);
      case Routes.detailsRoute:
      UserListResponseModel userListResponseModel=settings.arguments as UserListResponseModel;
      return pageRoute(DetailView(name: userListResponseModel), settings);
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Text('This Page does not Exist'),
                ));
    }
  }

  static pageRoute(Widget child, RouteSettings settings) {
    return FadeRoute(
      child: child,
      routeName: settings.name,
      arguments: settings.arguments,
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;
  final Object? arguments;

  FadeRoute({
    this.child,
    this.routeName,
    this.arguments,
  }) : super(
          settings: RouteSettings(name: routeName, arguments: arguments),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
