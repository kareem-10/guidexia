import 'package:flutter/material.dart';

class ListSheet extends StatelessWidget {
  final String title;
  final String emptyText;
  final bool isEmpty;
  final List<Widget> children;

  const ListSheet({
    super.key,
    required this.title,
    required this.emptyText,
    required this.isEmpty,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.65,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 14),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isEmpty)
                Expanded(child: Center(child: Text(emptyText)))
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: children.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, index) => children[index],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
