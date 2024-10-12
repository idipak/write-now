
import '../controllers/auth_controller.dart';

abstract class AutServiceInterface{
  User? getLoggedInUser();
  Future<void> logOut();
}