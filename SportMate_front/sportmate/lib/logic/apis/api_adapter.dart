import 'package:sportmate/logic/apis/comment_api.dart';
import 'package:sportmate/logic/apis/friend_api.dart';
import 'package:sportmate/logic/apis/join_api.dart';
import 'package:sportmate/logic/apis/practice_api.dart';
import 'package:sportmate/logic/apis/user_api.dart';

import 'event_api.dart';

class ApiAdapter{
  final UserApi _userApi = UserApi();
  final EventApi _eventApi = EventApi();
  final FriendApi _friendApi = FriendApi();
  final JoinApi _joinApi = JoinApi();
  final PracticeApi _practiceApi = PracticeApi();
  final CommentApi _commentApi = CommentApi();

  UserApi get userApi => _userApi;
  EventApi get eventApi => _eventApi;
  FriendApi get friendApi => _friendApi;
  PracticeApi get practiceApi => _practiceApi;
  JoinApi get joinApi => _joinApi;
  CommentApi get commentApi => _commentApi;
}