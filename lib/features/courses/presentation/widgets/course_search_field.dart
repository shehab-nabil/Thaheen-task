import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class CourseSearchField extends StatelessWidget {
  const CourseSearchField({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: S.of(context).searchHint,
        prefixIcon: const Icon(Icons.search_rounded),
      ),
    );
  }
}
