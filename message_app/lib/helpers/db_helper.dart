import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:message_app/models/CallsDetails.dart';
import 'package:message_app/models/ChatUser.dart';
import 'package:message_app/models/Message.dart';
import 'package:message_app/models/status.dart';

class DbHelper {
  final chatUsersWhatsapp = Hive.box("chatUsersWhatsapp");
  final callsWhatsapp = Hive.box("callsWhatsapp");
  final statusWhatsapp = Hive.box("statusWhatsapp");
  final messagesWhatsapp = Hive.box("messageWhatsapp");


  getChatUsersListenable() {
    return chatUsersWhatsapp.listenable();
  }

  editChatUser(ChatUser value) {
    if (chatUsersWhatsapp.containsKey(value.id)) {
      return chatUsersWhatsapp.put(value.id.toString(), value);
    } else {
      return chatUsersWhatsapp.put(value.id.toString(), value);
    }
  }

  deletChatUser(key) {
    chatUsersWhatsapp.delete(key);
  }

  getCallsListenable() {
    return callsWhatsapp.listenable();
  }

  editCall(CallDetails value) {
    if (callsWhatsapp.containsKey(value.id)) {
      return callsWhatsapp.put(value.id.toString(), value);
    } else {
      return callsWhatsapp.put(value.id.toString(), value);
    }
  }

  deletcall(key) {
    callsWhatsapp.delete(key);
  }

  getStatusListenable() {
    return statusWhatsapp.listenable();
  }

  editstatus(Status value) {
    if (statusWhatsapp.containsKey(value.id)) {
      return statusWhatsapp.put(value.id.toString(), value);
    } else {
      return statusWhatsapp.put(value.id.toString(), value);
    }
  }

  deletStatus(key) {
    statusWhatsapp.delete(key);
  }

  getWhatsappMessagesListenable() {
    return messagesWhatsapp.listenable();
  }

  addWhatsappMessages(Message value) {
    {
      return messagesWhatsapp.put(value.id.toString(), value);
    }
  }

  deletWhatsappMessages(key) {
    messagesWhatsapp.delete(key);
  }

  clearHieve() {
    Hive.box('messageWhatsapp').clear();
  }
}

final dbHelper = DbHelper();
