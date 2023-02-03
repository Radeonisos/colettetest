part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  const ActivitiesLoaded(this.activitiesList);

  final ActivitiesList activitiesList;

  @override
  List<Object> get props => [activitiesList];
}

class ActivitiesError extends ActivitiesState {}
