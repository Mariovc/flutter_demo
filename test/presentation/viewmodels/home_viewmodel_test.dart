import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late HomeViewModel viewModel;
  late MockGetImagesUseCase mockGetImagesUseCase;
  late MockMainNavigation mockMainNavigation;

  setUp(() {
    mockGetImagesUseCase = MockGetImagesUseCase();
    mockMainNavigation = MockMainNavigation();
    viewModel = HomeViewModel(mockMainNavigation, mockGetImagesUseCase);
    provideDummy<Either<MainError, List<ImageEntity>>>(const Right([]));
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('Initial state is correct', () {
    expect(viewModel.controller.itemList, isNull);
  });

  test('Fetch page updates controller', () async {
    final image = createImage();

    when(mockGetImagesUseCase(
      query: anyNamed('query'),
      pageSize: anyNamed('pageSize'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => Right([image]));

    await viewModel.fetchPage(1);

    expect(viewModel.controller.itemList, [image]);
  });

  test('Search updates controller', () async {
    final image = createImage();

    when(mockGetImagesUseCase(
      query: anyNamed('query'),
      pageSize: anyNamed('pageSize'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => Right([image]));

    await viewModel.fetchPage(1);
    expect(viewModel.controller.itemList, [image]);

    fakeAsync((async) {
      viewModel.search('test');
      async.elapse(const Duration(milliseconds: 500));
    });
    expect(viewModel.controller.itemList, null);
  });

  test('Navigate to detail calls navigator', () {
    final image = createImage();

    viewModel.navigateToDetail(image);

    verify(mockMainNavigation.navigateToDetail(image)).called(1);
  });

  test('Load items refreshes controller', () async {
    final image = createImage();

    when(mockGetImagesUseCase(
      query: anyNamed('query'),
      pageSize: anyNamed('pageSize'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => Right([image]));

    await viewModel.fetchPage(1);
    expect(viewModel.controller.itemList, [image]);

    await viewModel.loadItems();
    expect(viewModel.controller.itemList, null);
  });

  test('Fetch page handles errors', () async {
    when(mockGetImagesUseCase(
      query: anyNamed('query'),
      pageSize: anyNamed('pageSize'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => Left(ServerError()));

    await viewModel.fetchPage(1);

    expect(viewModel.controller.error, 'errors.server'.tr());
  });
}
