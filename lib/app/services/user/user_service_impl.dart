import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/local_storage/local_storage.dart';
import 'package:tmdb/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  UserServiceImpl(
      {required UserRepository userRepository,
      required LocalStorage localStorage,
      required LocalSecureStorage localSecureStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;

  @override
  Future<void> login(String username, String password) async {
    final sessionId = await _userRepository.login(username, password);
    await _saveSessionId(sessionId);
    await _getUserData();
  }

  Future<void> _saveSessionId(String sessionId) =>
      _localSecureStorage.write(Constants.LOCAL_STORAGE_SESSIONID, sessionId);

  Future<void> _getUserData() async {
    final userModel = await _userRepository.getUserBySession();
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_USER_DATA, userModel.toJson());
  }

  @override
  Future<void> logout() async {
    final sessionId =
        await _localSecureStorage.read(Constants.LOCAL_STORAGE_SESSIONID) ??
            false;
    final sessionDel = await _userRepository.deleteSession(sessionId);

    if (sessionDel == true) {
      await _localSecureStorage.clear();
      await _localStorage.clear();
    }
  }
}
