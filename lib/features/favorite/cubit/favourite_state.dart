part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
class FavouriteLoading extends FavouriteState {}

class FavouriteUpdated extends FavouriteState {}
class FavouriteSuccess extends FavouriteState {
 final List<ProgramModel>programmes;

  FavouriteSuccess({required this.programmes});
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
