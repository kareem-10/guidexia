import 'package:flutter/material.dart';
import 'package:tourist_app/core/widgets/app_bar_title.dart';
import 'package:tourist_app/features/stays/view/widgets/stays_body.dart';

class StaysScreen extends StatelessWidget {
  const StaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StaysView();
  }
}

class _StaysView extends StatelessWidget {
  const _StaysView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(text: 'Find Stay'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SafeArea(top: false, child: StaysBody()),
    );
  }
}
