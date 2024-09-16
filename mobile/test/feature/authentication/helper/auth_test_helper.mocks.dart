// Mocks generated by Mockito 5.4.4 from annotations
// in transittrack/test/feature/authentication/helper/auth_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i10;
import 'dart:typed_data' as _i12;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter/foundation.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;
import 'package:transittrack/core/error/failure.dart' as _i7;
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart'
    as _i8;
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOSOptions_1 extends _i1.SmartFake implements _i3.IOSOptions {
  _FakeIOSOptions_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAndroidOptions_2 extends _i1.SmartFake
    implements _i3.AndroidOptions {
  _FakeAndroidOptions_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLinuxOptions_3 extends _i1.SmartFake implements _i3.LinuxOptions {
  _FakeLinuxOptions_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWindowsOptions_4 extends _i1.SmartFake
    implements _i3.WindowsOptions {
  _FakeWindowsOptions_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebOptions_5 extends _i1.SmartFake implements _i3.WebOptions {
  _FakeWebOptions_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMacOsOptions_6 extends _i1.SmartFake implements _i3.MacOsOptions {
  _FakeMacOsOptions_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_7 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_8 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i5.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>> signup({
    required String? fullName,
    required String? phoneNumber,
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signup,
          [],
          {
            #fullName: fullName,
            #phoneNumber: phoneNumber,
            #email: email,
            #password: password,
          },
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>.value(
                _FakeEither_0<_i7.Failure, _i8.UserCredential>(
          this,
          Invocation.method(
            #signup,
            [],
            {
              #fullName: fullName,
              #phoneNumber: phoneNumber,
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>> login({
    required String? phoneNumber,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [],
          {
            #phoneNumber: phoneNumber,
            #password: password,
          },
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>.value(
                _FakeEither_0<_i7.Failure, _i8.UserCredential>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #phoneNumber: phoneNumber,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, void>> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, void>>.value(
            _FakeEither_0<_i7.Failure, void>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, void>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>> getUserCredential(
          String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserCredential,
          [token],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>.value(
                _FakeEither_0<_i7.Failure, _i8.UserCredential>(
          this,
          Invocation.method(
            #getUserCredential,
            [token],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.UserCredential>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, void>> changePassword({
    required String? newPassword,
    required String? confirmPassword,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #changePassword,
          [],
          {
            #newPassword: newPassword,
            #confirmPassword: confirmPassword,
          },
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, void>>.value(
            _FakeEither_0<_i7.Failure, void>(
          this,
          Invocation.method(
            #changePassword,
            [],
            {
              #newPassword: newPassword,
              #confirmPassword: confirmPassword,
            },
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, void>>);
}

/// A class which mocks [FlutterSecureStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterSecureStorage extends _i1.Mock
    implements _i3.FlutterSecureStorage {
  MockFlutterSecureStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.IOSOptions get iOptions => (super.noSuchMethod(
        Invocation.getter(#iOptions),
        returnValue: _FakeIOSOptions_1(
          this,
          Invocation.getter(#iOptions),
        ),
      ) as _i3.IOSOptions);

  @override
  _i3.AndroidOptions get aOptions => (super.noSuchMethod(
        Invocation.getter(#aOptions),
        returnValue: _FakeAndroidOptions_2(
          this,
          Invocation.getter(#aOptions),
        ),
      ) as _i3.AndroidOptions);

  @override
  _i3.LinuxOptions get lOptions => (super.noSuchMethod(
        Invocation.getter(#lOptions),
        returnValue: _FakeLinuxOptions_3(
          this,
          Invocation.getter(#lOptions),
        ),
      ) as _i3.LinuxOptions);

  @override
  _i3.WindowsOptions get wOptions => (super.noSuchMethod(
        Invocation.getter(#wOptions),
        returnValue: _FakeWindowsOptions_4(
          this,
          Invocation.getter(#wOptions),
        ),
      ) as _i3.WindowsOptions);

  @override
  _i3.WebOptions get webOptions => (super.noSuchMethod(
        Invocation.getter(#webOptions),
        returnValue: _FakeWebOptions_5(
          this,
          Invocation.getter(#webOptions),
        ),
      ) as _i3.WebOptions);

  @override
  _i3.MacOsOptions get mOptions => (super.noSuchMethod(
        Invocation.getter(#mOptions),
        returnValue: _FakeMacOsOptions_6(
          this,
          Invocation.getter(#mOptions),
        ),
      ) as _i3.MacOsOptions);

  @override
  void registerListener({
    required String? key,
    required _i9.ValueChanged<String?>? listener,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerListener,
          [],
          {
            #key: key,
            #listener: listener,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterListener({
    required String? key,
    required _i9.ValueChanged<String?>? listener,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #unregisterListener,
          [],
          {
            #key: key,
            #listener: listener,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterAllListenersForKey({required String? key}) =>
      super.noSuchMethod(
        Invocation.method(
          #unregisterAllListenersForKey,
          [],
          {#key: key},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterAllListeners() => super.noSuchMethod(
        Invocation.method(
          #unregisterAllListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> write({
    required String? key,
    required String? value,
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #key: key,
            #value: value,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<String?> read({
    required String? key,
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<String?>.value(),
      ) as _i6.Future<String?>);

  @override
  _i6.Future<bool> containsKey({
    required String? key,
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<void> delete({
    required String? key,
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<Map<String, String>> readAll({
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<Map<String, String>>.value(<String, String>{}),
      ) as _i6.Future<Map<String, String>>);

  @override
  _i6.Future<void> deleteAll({
    _i3.IOSOptions? iOptions,
    _i3.AndroidOptions? aOptions,
    _i3.LinuxOptions? lOptions,
    _i3.WebOptions? webOptions,
    _i3.MacOsOptions? mOptions,
    _i3.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<bool?> isCupertinoProtectedDataAvailable() => (super.noSuchMethod(
        Invocation.method(
          #isCupertinoProtectedDataAvailable,
          [],
        ),
        returnValue: _i6.Future<bool?>.value(),
      ) as _i6.Future<bool?>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_7(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(_i11.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i12.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i12.Uint8List>.value(_i12.Uint8List(0)),
      ) as _i6.Future<_i12.Uint8List>);

  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_8(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
