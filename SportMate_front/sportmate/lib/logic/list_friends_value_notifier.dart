import 'package:flutter/material.dart';
import 'friend.dart';

class ListFriendsValueNotifier{
  ValueNotifier _valueNotifierRequest = ValueNotifier(<Friend>[]);
  ValueNotifier _valueNotifierFriends = ValueNotifier(<Friend>[]);


  ValueNotifier get valueNotifierFriends => _valueNotifierFriends;
  set valueNotifierFriends(ValueNotifier value) {
    _valueNotifierFriends = value;
  }

  ValueNotifier get valueNotifierRequest => _valueNotifierRequest;
  set valueNotifierRequest(ValueNotifier value) {
    _valueNotifierRequest = value;
  }
}