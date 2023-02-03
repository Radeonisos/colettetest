part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
}

class ActivitiesStarted extends ActivitiesEvent {
  @override
  List<Object> get props => [];
}

class ActivitiesMine extends ActivitiesEvent {
  @override
  List<Object> get props => [];
}

class ActivitiesCached extends ActivitiesEvent {
  @override
  List<Object> get props => [];
}

class SwitchStatusRegister extends ActivitiesEvent {
  const SwitchStatusRegister(this.id, this.isMine);

  final int id;
  final bool isMine;

  @override
  List<Object> get props => [id, isMine];
}
