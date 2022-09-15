import 'package:flutter/cupertino.dart';
import 'package:test_assignment/presentation/screen/logged_in_screen.dart';

import 'presentation/screen/login_screen.dart';

class Routers {
  static Map<String, WidgetBuilder> toRoutes() {
    return {};
  }

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoggedInScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoggedInScreen());
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      default:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
