// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fordev/data/http/http.dart';
import 'package:fordev/domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel({
    required this.accessToken,
  });

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(accessToken: json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}
