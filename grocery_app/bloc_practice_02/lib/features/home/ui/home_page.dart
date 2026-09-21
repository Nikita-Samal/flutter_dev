import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../settings/ui/settings_page.dart';
import '../bloc/home_bloc.dart';
import '../../../shared/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Text(
                  '${state.counter}',
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: Icons.remove,
                  onPressed: () {
                    context.read<HomeBloc>().add(const DecrementCounter());
                  },
                ),
                const SizedBox(width: 16),
                CustomButton(
                  icon: Icons.refresh,
                  onPressed: () {
                    context.read<HomeBloc>().add(const ResetCounter());
                  },
                ),
                const SizedBox(width: 16),
                CustomButton(
                  icon: Icons.add,
                  onPressed: () {
                    context.read<HomeBloc>().add(const IncrementCounter());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
