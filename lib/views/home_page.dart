import 'package:flutter/material.dart';
import 'package:flutter_chatbot/models/chat_message.dart';
import 'package:flutter_chatbot/widgets/chat_message_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // vetor de menssagem
  final _messageList = <ChatMessage>[];
  final _controllerText = new TextEditingController();

  void dispose(){
    super.dispose();
    _controllerText.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Chat Bot - Trabalho'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          _buildList(),
          Divider(height: 1.0),
          _buildUserInput(),
        ],
      ),
    );
  }

  // cria a lista de mensagem
  _buildList() {
    return Flexible(
        child: ListView.builder(
            padding: EdgeInsets.all(7.0),
            itemBuilder:(_,int index) =>
                  ChatMessageListItem(chatMessage: _messageList[index]),
            itemCount: _messageList.length,
        ),
    );
  }

  // monta uma linha com o campo de texto e o botao de envio
  _buildUserInput(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children:<Widget> [
          _buildTextFild(),
          _buildSendButton(),
        ],
      ),
    );
  }

  // campo para escrever
  _buildTextFild(){
    return new Flexible(
        child:new TextField(
          controller: _controllerText,
          decoration: new InputDecoration(
            hintText: 'Invia messaggio'
          ),
        ),
    );
  }

  // botao para enviar
  _buildSendButton() {
    return new Container(
      child: new IconButton(
          onPressed: (){
            _sendMessage(text: _controllerText.text);
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).accentColor,
          ),
      ) ,
      margin: new EdgeInsets.only(left: 8.0),
    );
  }

  _dialogFlowRequest({String query}) async {
    // o codigo será inserido aqui.
  }

  _sendMessage({String text}) {
    _controllerText.clear();
    _addMessage(name: 'Fulano', text: text, type:ChatMessageType.send);
  }

   _addMessage({String name,String text, ChatMessageType type}) {
     var message = ChatMessage(
       text: text,
       name: name,
       type: type,
     );
     setState(() {
       _messageList.insert(0, message);
     }
     );
     if(type == ChatMessageType.send){
       // envia a menssagem para o bot e aguarda a resposta
       _dialogFlowRequest(query: message.text);
     }
   }

}
