part of 'programs_cubit.dart';

@immutable
sealed class ProgramsState {}

final class ProgramsInitial extends ProgramsState {}
final class ProgramsLoading extends ProgramsState {}
final class ProgramsLoadEmpty extends ProgramsState {
  final List<ProgramModel> programs;
  ProgramsLoadEmpty(this.programs);
}
final class ProgramsError extends ProgramsState {
  final String errorMsg;
  ProgramsError({required this.errorMsg});
}
final class ProgramsLoaded extends ProgramsState {
  final List<ProgramModel> programs;
  ProgramsLoaded(this.programs);
}