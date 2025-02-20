import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dio_client.dart';
import '../../models/asset.dart';
import 'asset_repo.dart';

// StateNotifier to manage asset list
class AssetController extends StateNotifier<AsyncValue<List<Assets>>> {
  final AssetRepository repository;
  AssetController(this.repository) : super(const AsyncValue.loading()) {
    fetchAssets();
  }

  List<Assets> _allAssets = []; // Store all assets for filtering

  Future<void> fetchAssets() async {
    try {
      state = const AsyncValue.loading();
      final assets = await repository.fetchAssets();
      _allAssets = assets;
      state = AsyncValue.data(assets);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void searchAssets(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allAssets);
    } else {
      final filteredAssets = _allAssets
          .where((asset) =>
              asset.title!.toLowerCase().contains(query.toLowerCase()) ||
              (asset.description?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
      state = AsyncValue.data(filteredAssets);
    }
  }
}

// Provider for AssetController
final assetControllerProvider = StateNotifierProvider.autoDispose<
        AssetController, AsyncValue<List<Assets>>>(
    (ref) => AssetController(ref.watch(assetRepositoryProvider)));

// Provider for AssetRepository
final assetRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return AssetRepository(dioClient: dioClient);
});

final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio();
});

final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioInstanceProvider);
  return DioClient(dio);
});
