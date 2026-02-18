import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:study_path/features/home/data/model/program_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final Set<String> favoriteProgramsIds = {};
  StreamSubscription<QuerySnapshot>? _favoritesSubscription;


  /// One-time toggle for the current user, then refresh favourites.
  bool isFavorite(String? programId) {
    if (programId == null) return false;
    if (state is FavouriteSuccess) {
      return (state as FavouriteSuccess).programmes.any((p) => p.id == programId);
    }
    return false;
  }

  Future<void> addToFavourite(ProgramModel programme) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || programme.id == null) return;

    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("bookmarks")
        .doc(programme.id);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.delete();
        print("تم الحذف بنجاح");
      } else {
        await docRef.set(programme.toJson());
        print("تمت الإضافة بنجاح");
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  /// Manual reload (used by "Reload page" buttons).
  Future<void> loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    emit(FavouriteLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("bookmarks")
          .get();

      _handleSnapshot(snapshot);
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  /// Start listening so favourites always reflect the current signed-in user
  /// (including immediately after sign-in).
  void listenToFavorites() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    emit(FavouriteLoading());
    _favoritesSubscription?.cancel();
    _favoritesSubscription = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("bookmarks")
        .snapshots()
        .listen(
      (snapshot) {
        final programmes = snapshot.docs.map((doc) {
          return ProgramModel.fromFirestore(doc);
        }).toList();
        emit(FavouriteSuccess(programmes: programmes));
        },
      onError: (error) {
        emit(FavouriteError(error.toString()));
      },
    );
  }

  void _handleSnapshot(QuerySnapshot snapshot) {
    favoriteProgramsIds.clear();
    favoriteProgramsIds.addAll(snapshot.docs.map((doc) => doc.id));

    final programmes = snapshot.docs
        .map((doc) => ProgramModel.fromJson(
              doc.data() as Map<String, dynamic>,
            ))
        .toList();

    emit(FavouriteSuccess(programmes: programmes));
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
