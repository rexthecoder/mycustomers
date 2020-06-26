import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/enums/message_type.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int id;
  final String message, subject;

  @JsonKey(fromJson: typeFromJson, name: 'type', toJson: typeToJson)
  final MessageType messageType;

  Message(this.id, this.message, this.messageType, this.subject);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static MessageType typeFromJson(int type) {
    return MessageType.values[type + 1];
  }

  static int typeToJson(MessageType type) {
    return type.index + 1;
  }
}