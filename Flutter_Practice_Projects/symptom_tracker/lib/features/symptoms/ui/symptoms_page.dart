import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symptom_tracker/data/models/symptom.dart';
import 'package:symptom_tracker/features/symptoms/bloc/symptoms_cubit.dart';
import 'package:symptom_tracker/features/symptoms/ui/widgets/add_symptom_sheet.dart';
import 'package:symptom_tracker/features/symptoms/ui/widgets/symptom_card.dart';

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({super.key});

  void _showJsonDemo(BuildContext context, Symptom symptom) {
    final jsonMap = symptom.toJson();
    final pretty = const JsonEncoder.withIndent('  ').convert(jsonMap);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('JSON Serialization'),
        content: SingleChildScrollView(
          child: SelectableText(
            pretty,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: pretty));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('JSON copied to clipboard')),
              );
            },
            child: const Text('Copy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddSymptomSheet(
          onAdd: (symptom) {
            context.read<SymptomsCubit>().addSymptom(symptom);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Tracker'),
        actions: [
          IconButton(
            tooltip: 'About Freezed',
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Freezed + JSON'),
                  content: const Text(
                    'This app uses Freezed for immutable models and '
                    'json_serializable for clean toJson / fromJson.\n\n'
                    'Tap any card to see the generated JSON.\n\n'
                    'The optional "notes" field is the Week 04 exercise.',
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SymptomsCubit, List<Symptom>>(
        builder: (context, symptoms) {
          if (symptoms.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.health_and_safety_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text('No symptoms yet', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first one',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
            itemCount: symptoms.length,
            itemBuilder: (context, index) {
              final symptom = symptoms[index];
              return SymptomCard(
                symptom: symptom,
                onTap: () => _showJsonDemo(context, symptom),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Symptom'),
      ),
    );
  }
}
