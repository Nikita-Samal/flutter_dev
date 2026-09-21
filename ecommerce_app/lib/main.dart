import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/core/routes/app_router.dart';
import 'package:nikita/core/theme/app_theme.dart';
import 'package:nikita/core/utils/app_logger.dart';
import 'package:nikita/firebase_options.dart';

// Auth imports
import 'package:nikita/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nikita/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nikita/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/send_password_reset_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:nikita/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:nikita/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nikita/features/auth/presentation/bloc/auth_event.dart';

// Products imports
import 'package:nikita/features/products/data/datasources/product_remote_datasource.dart';
import 'package:nikita/features/products/data/repositories/product_repository_impl.dart';
import 'package:nikita/features/products/domain/usecases/get_featured_products_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:nikita/features/products/domain/usecases/get_products_usecase.dart';
import 'package:nikita/features/products/domain/usecases/search_products_usecase.dart';
import 'package:nikita/features/products/presentation/bloc/products_bloc.dart';

// Categories imports
import 'package:nikita/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:nikita/features/categories/data/repositories/category_repository_impl.dart';
import 'package:nikita/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:nikita/features/categories/presentation/bloc/categories_bloc.dart';

// Cart imports
import 'package:nikita/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:nikita/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:nikita/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:nikita/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:nikita/features/cart/presentation/bloc/cart_bloc.dart';

// Wishlist imports
import 'package:nikita/features/wishlist/data/datasources/wishlist_remote_datasource.dart';
import 'package:nikita/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:nikita/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:nikita/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';
import 'package:nikita/features/wishlist/presentation/bloc/wishlist_bloc.dart';

// Orders imports
import 'package:nikita/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:nikita/features/orders/data/repositories/order_repository_impl.dart';
import 'package:nikita/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:nikita/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:nikita/features/orders/domain/usecases/watch_user_orders_usecase.dart';
import 'package:nikita/features/orders/presentation/bloc/orders_bloc.dart';

// Profile imports
import 'package:nikita/features/profile/presentation/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppLogger.info('Firebase initialized');

  runApp(const NikitaApp());
}

class NikitaApp extends StatelessWidget {
  const NikitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase instances
    final firebaseAuth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // Data sources
    final authDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
    );
    final productDataSource = ProductRemoteDataSourceImpl(firestore: firestore);
    final categoryDataSource = CategoryRemoteDataSourceImpl(firestore: firestore);
    final cartDataSource = CartRemoteDataSourceImpl(firestore: firestore);
    final wishlistDataSource = WishlistRemoteDataSourceImpl(firestore: firestore);
    final orderDataSource = OrderRemoteDataSourceImpl(firestore);

    // Repositories — use named param 'remoteDataSource' as defined in each impl
    final authRepo = AuthRepositoryImpl(authDataSource);
    final productRepo = ProductRepositoryImpl(remoteDataSource: productDataSource);
    final categoryRepo = CategoryRepositoryImpl(remoteDataSource: categoryDataSource);
    final cartRepo = CartRepositoryImpl(remoteDataSource: cartDataSource);
    final wishlistRepo = WishlistRepositoryImpl(remoteDataSource: wishlistDataSource);
    final orderRepo = OrderRepositoryImpl(remoteDataSource: orderDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            signIn: SignInUseCase(authRepo),
            signUp: SignUpUseCase(authRepo),
            signOut: SignOutUseCase(authRepo),
            passwordReset: SendPasswordResetUseCase(authRepo),
            getAuthState: GetAuthStateUseCase(authRepo),
          )..add(const AuthStarted()),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc(
            getProductsUseCase: GetProductsUseCase(productRepo),
            getFeaturedProductsUseCase: GetFeaturedProductsUseCase(productRepo),
            getProductByIdUseCase: GetProductByIdUseCase(productRepo),
            getProductsByCategoryUseCase: GetProductsByCategoryUseCase(productRepo),
            searchProductsUseCase: SearchProductsUseCase(productRepo),
          ),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => CategoriesBloc(
            getCategoriesUseCase: GetCategoriesUseCase(categoryRepo),
          ),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(
            getCartUseCase: GetCartUseCase(cartRepo),
            addToCartUseCase: AddToCartUseCase(cartRepo),
            updateCartQuantityUseCase: UpdateCartQuantityUseCase(cartRepo),
            removeFromCartUseCase: RemoveFromCartUseCase(cartRepo),
            clearCartUseCase: ClearCartUseCase(cartRepo),
          ),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => WishlistBloc(
            watchWishlistUseCase: WatchWishlistUseCase(wishlistRepo),
            toggleWishlistUseCase: ToggleWishlistUseCase(wishlistRepo),
          ),
        ),
        BlocProvider<OrdersBloc>(
          create: (context) => OrdersBloc(
            watchUserOrders: WatchUserOrdersUseCase(orderRepo),
            getOrderById: GetOrderByIdUseCase(orderRepo),
            createOrder: CreateOrderUseCase(orderRepo),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Nikita',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
