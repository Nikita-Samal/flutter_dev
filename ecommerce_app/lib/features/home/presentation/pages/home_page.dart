import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nikita/common/colors/app_colors.dart';
import 'package:nikita/features/home/domain/entities/banner_entity.dart';
import 'package:nikita/features/home/presentation/widgets/promo_banner.dart';
import 'package:nikita/features/home/presentation/widgets/home_section_header.dart';
import 'package:nikita/features/home/presentation/widgets/category_chip_row.dart';
import 'package:nikita/features/home/presentation/widgets/featured_products_row.dart';
import 'package:nikita/features/categories/domain/entities/category_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Hardcoded promo banners as requested
  final List<BannerEntity> _promoBanners = const [
    BannerEntity(
      id: '1',
      title: 'Summer Sale\nUp to 50% Off',
      subtitle: 'HOT DEALS',
    ),
    BannerEntity(
      id: '2',
      title: 'New Arrivals\nLatest Products',
      subtitle: 'JUST IN',
    ),
    BannerEntity(
      id: '3',
      title: 'Free Shipping\nOn orders over \$50',
      subtitle: 'LIMITED TIME',
    ),
  ];

  // Dummy categories until bloc integration
  final List<CategoryEntity> _dummyCategories = [
    CategoryEntity(id: '1', name: 'Electronics', productCount: 10, status: 'active', createdAt: DateTime.now()),
    CategoryEntity(id: '2', name: 'Fashion', productCount: 20, status: 'active', createdAt: DateTime.now()),
    CategoryEntity(id: '3', name: 'Home', productCount: 15, status: 'active', createdAt: DateTime.now()),
    CategoryEntity(id: '4', name: 'Beauty', productCount: 5, status: 'active', createdAt: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    // In a real app, listen to AuthBloc for the username
    const String userName = 'User'; 
    const bool isProductsLoading = true; // Set true to demonstrate skeletons

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0,
            backgroundColor: AppColors.surface,
            title: const Text(
              'Nikita',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textPrimary),
                onPressed: () => context.push('/search'),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary),
                onPressed: () => context.push('/cart'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                child: GestureDetector(
                  onTap: () => context.push('/profile'),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, size: 20, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              // 1. Greeting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  userName.isNotEmpty ? 'Good morning, $userName! 👋' : 'Good morning! 👋',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () => context.push('/search'),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey.shade500),
                        const SizedBox(width: 12),
                        Text(
                          'Search for products...',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. PromoBanner
              PromoBanner(banners: _promoBanners),
              const SizedBox(height: 24),

              // 4. Shop by Category
              const HomeSectionHeader(title: 'Shop by Category'),
              CategoryChipRow(
                categories: _dummyCategories,
                onCategorySelected: (category) => context.push('/products?categoryId=\${category.id}'),
                isLoading: false,
              ),
              const SizedBox(height: 24),

              // 5. Featured Products
              HomeSectionHeader(
                title: 'Featured Products',
                onSeeAll: () => context.push('/products?featured=true'),
              ),
              FeaturedProductsRow(
                products: const [],
                isLoading: isProductsLoading,
              ),
              const SizedBox(height: 24),

              // 6. Popular Products
              HomeSectionHeader(
                title: 'Popular Products',
                onSeeAll: () => context.push('/products?popular=true'),
              ),
              FeaturedProductsRow(
                products: const [],
                isLoading: isProductsLoading,
              ),
              const SizedBox(height: 48), // Bottom padding
            ]),
          ),
        ],
      ),
    );
  }
}
