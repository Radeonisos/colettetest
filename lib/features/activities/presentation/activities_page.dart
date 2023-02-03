import 'package:flutter/material.dart';

import 'activites_view.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ActivitiesPage());
  }

  @override
  Widget build(BuildContext context) {
    return const ActivitiesView();
  }
}
