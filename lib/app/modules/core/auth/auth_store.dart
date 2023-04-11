import 'package:mobx/mobx.dart';
import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/local_storage/local_storage.dart';
import 'package:tmdb/app/models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;

  AuthStoreBase({required LocalStorage localStorage})
      : _localStorage = localStorage;
  @readonly
  UserModel? _userLogged;

  @action
  Future<void> loadUserLogged() async {
    final userModelJson =
        await _localStorage.read<String>(Constants.LOCAL_STORAGE_USER_DATA);

    if (userModelJson != null) {
      _userLogged = UserModel.fromJson(userModelJson);
    } else {
      _userLogged = UserModel.empty();
    }
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    _userLogged = UserModel.empty();
  }
}
