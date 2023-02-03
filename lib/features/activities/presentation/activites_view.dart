import 'package:colette_test/features/login/business_logic/blocs/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../business_logic/blocs/activities_bloc.dart';
import '../business_logic/models/activity_item.dart';
import 'activity_page.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const ActivitiesAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<ActivitiesBloc>().add(ActivitiesCached());
                    },
                    child: Text(AppLocalizations.of(context)!.all)),
                ElevatedButton(
                    onPressed: () {
                      context.read<ActivitiesBloc>().add(ActivitiesMine());
                    },
                    child: Text(AppLocalizations.of(context)!.mineActi)),
              ],
            ),
          ),
          BlocBuilder<ActivitiesBloc, ActivitiesState>(
            builder: (context, state) {
              if (state is ActivitiesLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is ActivitiesLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ActivityListItem(
                      state.activitiesList.getByPosition(index),
                    ),
                    childCount: state.activitiesList.activities.length,
                  ),
                );
              }
              return SliverFillRemaining(
                child: Text(AppLocalizations.of(context)!.errorShow),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ActivitiesAppBar extends StatelessWidget {
  const ActivitiesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(AppLocalizations.of(context)!.activities),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested()),
        ),
      ],
    );
  }
}

class ActivityListItem extends StatelessWidget {
  const ActivityListItem(this.item, {super.key});

  final ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityPage(item.id)),
          );
        },
        child: Card(
          child: Column(
            children: [
              const FlutterLogo(),
              Text(item.title),
              Text(item.description),
              Text(item.start.toIso8601String()),
              Text(item.numberAttendees.toString())
            ],
          ),
        ),
      ),
    );
  }
}
