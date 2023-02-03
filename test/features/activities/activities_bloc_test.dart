import 'package:bloc_test/bloc_test.dart';
import 'package:colette_test/features/activities/business_logic/blocs/activities_bloc.dart';
import 'package:colette_test/features/activities/business_logic/models/models.dart';
import 'package:colette_test/features/activities/data/models/activity_model.dart';
import 'package:colette_test/features/activities/data/repositories/activities_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockActivitesRepository extends Mock implements ActivitesRepository {}

void main() {
  group('ActivitiesBloc', () {
    DateTime dateTest = DateTime.parse("2023-02-27T00:00:00+00:00");
    String dateString = "2023-02-27T00:00:00+00:00";
    List<ActivityModel> mockModelActivities = [
      ActivityModel(
          id: 1,
          title: 'Title',
          description: 'description',
          start: dateString,
          isRegister: true,
          numberAttendees: 5),
      ActivityModel(
          id: 2,
          title: 'Title',
          description: 'description',
          start: dateString,
          isRegister: false,
          numberAttendees: 50),
    ];
    List<ActivityItem> mockItemActivities = [
      ActivityItem(1, 'Title', 'description', dateTest, true, 5),
      ActivityItem(2, 'Title', 'description', dateTest, false, 50)
    ];

    late ActivitiesBloc activitiesBloc;
    late ActivitesRepository activitiesRepository;

    setUp(() {
      activitiesRepository = MockActivitesRepository();
      activitiesBloc =
          ActivitiesBloc(activitiesRepository: activitiesRepository);
    });

    test('the initial state for Activities Bloc is ActivitiesLoading', () {
      expect(activitiesBloc.state, ActivitiesLoading());
    });

    blocTest(
      'the bloc should emit loading then error',
      build: () => activitiesBloc,
      act: (bloc) => bloc.add(ActivitiesStarted()),
      expect: () => [ActivitiesLoading(), ActivitiesError()],
    );

    blocTest<ActivitiesBloc, ActivitiesState>(
      'emits ActivitiesStarted then the activities give list ActivityItem',
      setUp: () {
        when(activitiesRepository.getActivities)
            .thenAnswer((_) async => mockModelActivities);
      },
      build: () => ActivitiesBloc(activitiesRepository: activitiesRepository),
      act: (bloc) => bloc.add(ActivitiesStarted()),
      expect: () => <ActivitiesState>[
        ActivitiesLoading(),
        ActivitiesLoaded(ActivitiesList(activities: mockItemActivities)),
      ],
      verify: (_) => verify(activitiesRepository.getActivities).called(1),
    );
    tearDown(() {
      activitiesBloc.close();
    });
  });
}
