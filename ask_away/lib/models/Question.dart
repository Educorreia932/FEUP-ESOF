class Question {
  String id;
  String text;
  int votes;
  String user;

  Question(String text, int votes, String id, String user) {
    this.text = text;
    this.votes = votes;
    this.id = id;
    this.user = user;
  }

  int getTotalVotes() {
    return votes;
  }
}
