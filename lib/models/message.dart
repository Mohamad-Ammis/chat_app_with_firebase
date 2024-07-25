class Message {
  final String messageText;
  final String id;

  Message(this.messageText, this.id);
  factory Message.fromjson(jsondata) {
    return Message(jsondata['message'], jsondata['id']);
  }
}
