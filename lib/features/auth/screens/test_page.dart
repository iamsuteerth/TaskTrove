import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/auth/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(
              text: code,
              style: appstyle(
                30,
                AppConstants.kLight,
                FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(codeStateProvider.notifier).setStart("Booba");
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
