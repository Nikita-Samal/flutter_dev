import 'package:flutter/material.dart';

import '../../../common/colours_palette.dart';

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});
  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  int _selectedNav = 0, _cartCount = 2;
  String _selectedCategory = 'Popular';
  final _categories = const [
    ('Popular', Icons.local_fire_department_rounded),
    ('Fruits', Icons.apple_rounded),
    ('Veggies', Icons.eco_rounded),
    ('Dairy', Icons.water_drop_rounded),
  ];
  final _products = const [
    _Product(
      'Organic avocado',
      'Hass · 1 piece',
      '₹79',
      Icons.spa_rounded,
      ColoursPalette.peach,
    ),
    _Product(
      'Baby spinach',
      'Fresh · 250 g',
      '₹65',
      Icons.grass_rounded,
      ColoursPalette.yellow,
    ),
    _Product(
      'Sweet oranges',
      'Valencia · 1 kg',
      '₹120',
      Icons.circle_rounded,
      Color(0xFFFFD8A7),
    ),
    _Product(
      'Whole milk',
      'Farm fresh · 1 L',
      '₹68',
      Icons.local_drink_rounded,
      Color(0xFFDDEBFF),
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildSearch()),
          SliverToBoxAdapter(child: _buildDeliveryCard()),
          SliverToBoxAdapter(
            child: _buildSectionTitle('Shop by category', 'See all'),
          ),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(
            child: _buildSectionTitle('Popular near you', 'View all'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (c, i) => _buildProductCard(_products[i]),
                childCount: _products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: .66,
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: _buildBottomNavigation(),
  );
  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DELIVERING TO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  color: ColoursPalette.muted,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  Text(
                    'Koregaon Park, Pune',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: ColoursPalette.ink,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 44,
          width: 44,
          decoration: const BoxDecoration(
            color: ColoursPalette.forest,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person_outline_rounded, color: Colors.white),
        ),
      ],
    ),
  );
  Widget _buildSearch() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search for groceries',
        hintStyle: const TextStyle(color: ColoursPalette.muted),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: ColoursPalette.forest,
        ),
        suffixIcon: const Icon(
          Icons.tune_rounded,
          color: ColoursPalette.forest,
        ),
        filled: true,
        fillColor: ColoursPalette.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
  Widget _buildDeliveryCard() => Container(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 26),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: ColoursPalette.forest,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Freshness at your door.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 21,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                'Free delivery on orders above ₹499',
                style: TextStyle(color: Color(0xFFC4DACD), fontSize: 12),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: ColoursPalette.lime,
                  foregroundColor: ColoursPalette.ink,
                ),
                child: const Text('Shop now'),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.local_shipping_rounded,
          size: 72,
          color: ColoursPalette.lime,
        ),
      ],
    ),
  );
  Widget _buildSectionTitle(String title, String action) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: ColoursPalette.ink,
            ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: ColoursPalette.leaf,
          ),
        ),
      ],
    ),
  );
  Widget _buildCategories() => SizedBox(
    height: 107,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: _categories.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final item = _categories[index];
        final selected = _selectedCategory == item.$1;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = item.$1),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: selected
                      ? ColoursPalette.forest
                      : ColoursPalette.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  item.$2,
                  color: selected ? ColoursPalette.lime : ColoursPalette.leaf,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                item.$1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: ColoursPalette.ink,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  Widget _buildProductCard(_Product product) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ColoursPalette.surface,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 104,
          width: double.infinity,
          decoration: BoxDecoration(
            color: product.color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  product.icon,
                  size: 56,
                  color: ColoursPalette.forest,
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 19,
                  color: ColoursPalette.forest,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: ColoursPalette.ink,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          product.detail,
          style: const TextStyle(fontSize: 11, color: ColoursPalette.muted),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              product.price,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            InkWell(
              onTap: () => setState(() => _cartCount++),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: ColoursPalette.lime,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add_rounded, size: 18),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  Widget _buildBottomNavigation() => NavigationBar(
    selectedIndex: _selectedNav,
    onDestinationSelected: (value) => setState(() => _selectedNav = value),
    backgroundColor: ColoursPalette.surface,
    destinations: [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view_rounded),
        label: 'Browse',
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('$_cartCount'),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
        selectedIcon: Badge(
          label: Text('$_cartCount'),
          child: const Icon(Icons.shopping_bag_rounded),
        ),
        label: 'Cart',
      ),
      const NavigationDestination(
        icon: Icon(Icons.person_outline_rounded),
        selectedIcon: Icon(Icons.person_rounded),
        label: 'Profile',
      ),
    ],
  );
}

class _Product {
  const _Product(this.name, this.detail, this.price, this.icon, this.color);
  final String name, detail, price;
  final IconData icon;
  final Color color;
}
