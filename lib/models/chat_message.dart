  enum ChatMessageType{send,received }

  class ChatMessage{

    final String name;
    final String text;
    final ChatMessageType type;

    ChatMessage({
      this.name,
      this.text,
      this.type = ChatMessageType.send,
    });

  }
