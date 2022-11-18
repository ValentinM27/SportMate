import 'package:sportmate/logic/apis/api_adapter.dart';
import 'package:sportmate/logic/palette.dart';
import 'package:sportmate/logic/sport_enum.dart';

class Service{
  final ApiAdapter _api = ApiAdapter();
  final Palette _palette = Palette();
  final SportEnum _sportEnum = SportEnum();

  ApiAdapter get apis => _api;
  Palette get couleurs => _palette;
  SportEnum get sportEnum => _sportEnum;
}