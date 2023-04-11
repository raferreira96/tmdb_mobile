import '../../models/user_model.dart';

abstract class UserRepository {
  Future<String> requestToken();
  Future<String> createSession(requestToken);
  Future<bool> deleteSession(sessionId);
  Future<String> login(String username, String password);
  Future<UserModel> getUserBySession();
}
