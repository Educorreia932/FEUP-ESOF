class Question {
  String id;
  String text;
  int votes;
  String user;
  bool accepted;

  Question(String text, int votes, String id, String user, bool accepted) {
    this.text = text;
    this.votes = votes;
    this.id = id;
    this.user = user;
    this.accepted = accepted;
  }

  int getTotalVotes() {
    return votes;
  }
}
