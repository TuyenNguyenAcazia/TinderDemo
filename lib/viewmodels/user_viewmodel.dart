import 'package:testing/model/user.dart';
import 'package:testing/services/local_storage.dart';
import 'package:testing/services/user_api_client.dart';
import 'package:testing/viewmodels/base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  final UserApiClient apiClient;
  final LocalStorage localStorage;

  List<User> users = [];

  UserViewModel(this.apiClient, this.localStorage);

  fetchUser() async {
    setBusy(true);
    try {
      var user1 = apiClient.fetchRandomUser();
      var user2 = apiClient.fetchRandomUser();
      var user3 = apiClient.fetchRandomUser();
      var users = await Future.wait([user1, user2, user3], eagerError: true);
      this.users.addAll(users);
      notifyListeners();
      setBusy(false);
    } catch (_) {
      setError(true);
    }
  }

  swipeLeft() {
    swapItem(users, 0, 1);
    swapItem(users, 1, 2);
    notifyListeners();
  }

  fetchNextUser() async {
    try {
      var user = await apiClient.fetchRandomUser();
      this.users.removeLast();
      this.users.add(user);
      notifyListeners();
    } catch (_) {
      setError(true);
    }
  }

  addToFavorite(User user) async {
    print(user.username);
    await localStorage.addUser(user);
  }

  swapItem(List<User> users, int index1, int index2) {
    User temp = users[index1];
    users[index1] = users[index2];
    users[index2] = temp;
  }
}
