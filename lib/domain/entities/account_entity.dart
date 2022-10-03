// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountEntity {
  final String token;
  AccountEntity({
    required this.token,
  });

  factory AccountEntity.fromJson(Map json) =>
      AccountEntity(token: json['accessToken']);
}
