class AppRoutes {
  AppRoutes._();
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String products = '/products';
  static const String productDetail = '/products/:id';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String wishlist = '/wishlist';
  
  static String productDetailPath(String id) => '/products/$id';
  static String orderDetailPath(String id) => '/orders/$id';
}
