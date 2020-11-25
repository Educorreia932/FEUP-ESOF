import 'AppUser.dart';

enum VoteType { up, down }

class Vote {
  User user;
  VoteType type;

  // Casted time
  Vote(this.type) {
    this.type = type;
  }
}
