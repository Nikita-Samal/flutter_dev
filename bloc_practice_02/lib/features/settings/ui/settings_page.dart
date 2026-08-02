import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../bloc/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.settingsTitle),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: Text(state.isDarkMode ? 'On' : 'Off'),
                value: state.isDarkMode,
                onChanged: (value) {
                  context.read<SettingsCubit>().setDarkMode(value);
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Flutter Bloc Feature-First Demo'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: AppConstants.appName,
                applicationVersion: '1.0.0',
                applicationLegalese: 'Demo project for learning Bloc + feature architecture',
              );
            },
          ),
        ],
      ),
    );
  }
}
