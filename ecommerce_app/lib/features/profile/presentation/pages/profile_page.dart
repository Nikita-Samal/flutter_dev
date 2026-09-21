import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikita/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nikita/features/profile/presentation/bloc/profile_event.dart';
import 'package:nikita/features/profile/presentation/bloc/profile_state.dart';
import 'package:nikita/features/profile/presentation/widgets/profile_header.dart';
import 'package:nikita/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:nikita/features/profile/presentation/widgets/profile_stats_row.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggingOut) {
          // Trigger auth signout here
          // e.g. context.read<AuthBloc>().add(SignOutRequested());
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Profile'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ProfileHeader(
                      name: user.name,
                      email: user.email,
                      imageUrl: user.imageUrl,
                      onEditPhoto: () {
                        context.read<ProfileBloc>().add(
                          ProfileImageUpdateRequested(userId: user.id, imageFile: null as dynamic), // Mocking file update
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 1),
                          ],
                        ),
                        child: ProfileStatsRow(
                          ordersCount: 12,
                          wishlistCount: 5,
                          reviewsCount: 3,
                          onOrdersTap: () => Navigator.pushNamed(context, '/orders'),
                          onWishlistTap: () => Navigator.pushNamed(context, '/wishlist'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionHeader('ACCOUNT'),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.shopping_bag_outlined,
                            title: 'My Orders',
                            onTap: () => Navigator.pushNamed(context, '/orders'),
                          ),
                          ProfileMenuItem(
                            icon: Icons.favorite_border,
                            title: 'My Wishlist',
                            onTap: () => Navigator.pushNamed(context, '/wishlist'),
                          ),
                          ProfileMenuItem(
                            icon: Icons.person_outline,
                            title: 'Edit Profile',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    _buildSectionHeader('PREFERENCES'),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.notifications_outlined,
                            title: 'Notifications',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.security_outlined,
                            title: 'Privacy & Security',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    _buildSectionHeader('SUPPORT'),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.help_outline,
                            title: 'Help Center',
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.info_outline,
                            title: 'About Nikita',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          context.read<ProfileBloc>().add(LogoutRequested());
                        },
                        child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
