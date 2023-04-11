abstract class UserService {
  Future<void> login(String username, String password);
  Future<void> logout();
}
