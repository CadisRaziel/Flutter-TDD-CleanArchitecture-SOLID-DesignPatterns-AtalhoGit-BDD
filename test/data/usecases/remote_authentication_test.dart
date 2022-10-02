// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/domain/usecases/usecade.dart';
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication? sut;
  HttpClientSpy? httpClient;
  String? url;
  AuthenticationParams? params;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(
      httpClient: httpClient!,
      url: url!,
    );
    params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
  });

  test('should call HttpCliente with correct values', () async {
    await sut!.auth(params!);

    verify(
      httpClient!.request(
        url: url!,
        method: 'post',
        body: {
          'email': params!.email,
          'password': params!.secret,
        },
      ),
    );
  });
  test('Should throw UnexcpectedError if HttpClient returns 400', () async {
    when(httpClient!.request(
      body: anyNamed('body'),
      method: anyNamed('method'),
      url: anyNamed('url'),
    )).thenThrow(HttpError.badRequest);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexcpectedError if HttpClient returns 404', () async {
    when(httpClient!.request(
      body: anyNamed('body'),
      method: anyNamed('method'),
      url: anyNamed('url'),
    )).thenThrow(HttpError.notFound);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexcpectedError if HttpClient returns 500', () async {
    when(httpClient!.request(
      body: anyNamed('body'),
      method: anyNamed('method'),
      url: anyNamed('url'),
    )).thenThrow(HttpError.serverError);

    final future = sut!.auth(params!);

    expect(future, throwsA(DomainError.unexpected));
  });
}
