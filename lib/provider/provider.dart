import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_test/models/product_model.dart';

final listFavProvider =
StateNotifierProvider<FavoriteController, List<Products>>(
        (ref) {
      return FavoriteController();
    });

class FavoriteController extends StateNotifier<List<Products>> {
  FavoriteController() : super([]);



  void addToFav(Products item) {
    state = [...state,item];
  }


  void clearAll(){
    state=[];
  }

  void removeFromFav(Products id) {
    state = state.where((element) => element != id).toList();
  }
}