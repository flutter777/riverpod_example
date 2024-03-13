



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_test/models/product_model.dart';

import '../repo/home_repo.dart';


final apiClientProvider = Provider<HomeRepo>((ref) => HomeRepo());

final productList =
FutureProvider.autoDispose<ProductModel>((ref) async {
  return ref.watch(apiClientProvider).getUserProfile();
});

