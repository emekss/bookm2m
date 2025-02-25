
import 'package:book_app_m2m/api/users/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users_model.dart';
import '../asset/asset_controller.dart';

class UserController extends StateNotifier<AsyncValue<List<UsersModel>>> {
  final UsersRepository repository;
  UserController(this.repository) : super(const AsyncValue.loading()) {
    fetchUsers();
  }

  List<UsersModel> _allUsers = [];

  /// Fetch all questions
  Future<void> fetchUsers() async {
    try {
      state = const AsyncValue.loading();
      final users = await repository.fetchUsers();
      _allUsers = users;
      state = AsyncValue.data(users);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allUsers);
    } else {
      final filteredUsers = _allUsers
          .where((q) => q.fullName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredUsers);
    }
  }
}
// Provider for QuestionsController
final usersControllerProvider = StateNotifierProvider.autoDispose<
    UserController, AsyncValue<List<UsersModel>>>(
  (ref) => UserController(ref.watch(userRepositoryProvider)),
);

// Provider for QuestionsRepository
final userRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return UsersRepository(dioClient: dioClient);
});