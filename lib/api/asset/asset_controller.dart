import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dio_client.dart';
import '../../models/asset.dart';
import '../../widgets/snackbars.dart';
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
      print(e);
      state = AsyncValue.error(e, stack);
    }
  }

  Future<String> createAssets({
    required BuildContext context,
    required File file,
    required String description,
    required String type,
    required List<String> taggedUsers,
  }) async {
    state = const AsyncValue.loading();
    try {
      final msg =
          await repository.uploadAsset(file, taggedUsers, type, description);
      showSuccessSnackBar(context, "$msg");
      print("✅ File uploaded successfully");

      await fetchAssets();
      Navigator.pop(context);
      return msg;
    } catch (e, stack) {
      showErrorSnackBar(context, e.toString());
      state = AsyncValue.error(e, stack);
      return e.toString();
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
