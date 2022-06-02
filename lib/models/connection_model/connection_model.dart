import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_model.freezed.dart';
part 'connection_model.g.dart';

@freezed
@immutable
class ConnectionModel with _$ConnectionModel {
  const factory ConnectionModel({
    required String connection,
  }) = _ConnectionModel;

  factory ConnectionModel.fromJson(Map<String, dynamic> json) => _$ConnectionModelFromJson(json);
}
