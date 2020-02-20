import 'package:testing/model/user.dart';

class Result {
  User user;
  String seed;
  String version;

  Result({this.user, this.seed, this.version});

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    seed = json['seed'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['seed'] = this.seed;
    data['version'] = this.version;
    return data;
  }
}
