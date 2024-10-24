// Mocks generated by Mockito 5.4.4 from annotations
// in images/test/presentation/viewmodels/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:go_router/go_router.dart' as _i3;
import 'package:images/domain/entities/image_entity.dart' as _i6;
import 'package:images/domain/repositories/image_repository.dart' as _i2;
import 'package:images/domain/usecases/get_images_usecase.dart' as _i4;
import 'package:images/presentation/navigation/main_navigation.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeImageRepository_0 extends _i1.SmartFake
    implements _i2.ImageRepository {
  _FakeImageRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGoRouter_1 extends _i1.SmartFake implements _i3.GoRouter {
  _FakeGoRouter_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetImagesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetImagesUseCase extends _i1.Mock implements _i4.GetImagesUseCase {
  MockGetImagesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ImageRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeImageRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ImageRepository);

  @override
  _i5.Future<List<_i6.ImageEntity>> call({
    required String? query,
    required int? pageSize,
    required int? page,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #query: query,
            #pageSize: pageSize,
            #page: page,
          },
        ),
        returnValue:
            _i5.Future<List<_i6.ImageEntity>>.value(<_i6.ImageEntity>[]),
      ) as _i5.Future<List<_i6.ImageEntity>>);
}

/// A class which mocks [MainNavigation].
///
/// See the documentation for Mockito's code generation for more information.
class MockMainNavigation extends _i1.Mock implements _i7.MainNavigation {
  MockMainNavigation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GoRouter get router => (super.noSuchMethod(
        Invocation.getter(#router),
        returnValue: _FakeGoRouter_1(
          this,
          Invocation.getter(#router),
        ),
      ) as _i3.GoRouter);

  @override
  _i5.Future<void> navigateToDetail(_i6.ImageEntity? image) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateToDetail,
          [image],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
