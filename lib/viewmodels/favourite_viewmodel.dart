import 'package:testing/model/user.dart';
import 'package:testing/services/local_storage.dart';
import 'package:testing/viewmodels/base_viewmodel.dart';

class FavouriteViewModel extends BaseViewModel {
  final LocalStorage localStorage;

  List<User> users;

  FavouriteViewModel(this.localStorage);

  getAllUsers() async {
    setBusy(true);
    var users = await localStorage.getAllUsers();
    this.users = users;
    setBusy(false);
  }

  removeUser(int index) async {
    this.users.removeAt(index);
    notifyListeners();
    await localStorage.setAllUsers(this.users);
  }
}