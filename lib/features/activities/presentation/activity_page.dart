import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../business_logic/blocs/activities_bloc.dart';
import '../business_logic/models/activity_item.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage(this.id, {Key? key}) : super(key: key);
  final int id;
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ActivitiesBloc, ActivitiesState>(
        builder: (context, state) {
          if (state is ActivitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ActivitiesLoaded) {
            ActivityItem item = state.activitiesList.getById(widget.id);
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FlutterLogo(
                      size: 300,
                    ),
                    Text(item.title),
                    Text(item.description),
                    Text(item.start.toIso8601String()),
                    Text(item.numberAttendees.toString()),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ActivitiesBloc>().add(
                              SwitchStatusRegister(item.id, !item.isRegister));
                        },
                        child: Text(item.isRegister ? 'Annuler' : "S'inscrire"))
                  ],
                ),
              ),
            );
          }
          return Text(AppLocalizations.of(context)!.errorShow);
        },
      ),
    );
  }
}
