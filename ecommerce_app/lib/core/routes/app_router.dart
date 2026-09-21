import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nikita/core/routes/app_routes.dart';
import 'package:nikita/features/auth/presentation/pages/login_page.dart';
import 'package:nikita/features/home/presentation/pages/home_shell_page.dart';
import 'package:nikita/features/home/presentation/pages/home_page.dart';
import 'package:nikita/features/products/presentation/pages/products_page.dart';
import 'package:nikita/features/products/presentation/pages/product_details_page.dart';
import 'package:nikita/features/products/presentation/pages/search_page.dart';
import 'package:nikita/features/categories/presentation/pages/categories_page.dart';
import 'package:nikita/features/cart/presentation/pages/cart_page.dart';
import 'package:nikita/features/orders/presentation/pages/orders_page.dart';
import 'package:nikita/features/orders/presentation/pages/order_detail_page.dart';
import 'package:nikita/features/profile/presentation/pages/profile_page.dart';
import 'package:nikita/features/wishlist/presentation/pages/wishlist_page.dart';

class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _isLoggedIn = user != null;
      notifyListeners();
    });
  }
  
  bool _isLoggedIn = FirebaseAuth.instance.currentUser != null;
  bool get isLoggedIn => _isLoggedIn;
}

class AppRouter {
  AppRouter._();
  
  static final _authNotifier = _AuthNotifier();
  
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.root,
    refreshListenable: _authNotifier,
    redirect: (context, state) {
      final isLoggedIn = _authNotifier.isLoggedIn;
      final loc = state.matchedLocation;
      final isAuthRoute = loc == AppRoutes.login || loc == AppRoutes.root;
      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && isAuthRoute) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.root,
        redirect: (_, __) => AppRoutes.login,
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeShellPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.categories,
              builder: (context, state) => const CategoriesPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.cart,
              builder: (context, state) => const CartPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.orders,
              builder: (context, state) => const OrdersPage(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => OrderDetailPage(orderNumber: state.pathParameters['id']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsPage(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) => ProductDetailsPage(productId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: AppRoutes.wishlist,
        builder: (context, state) => const WishlistPage(),
      ),
    ],
  );
}
