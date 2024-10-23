import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
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
    )).thenAnswer((_) async => [image]);

    await viewModel.fetchPage(1);

    expect(viewModel.controller.itemList, [image]);
  });

  test('Search updates controller', () async {
    final image = createImage();

    when(mockGetImagesUseCase(
      query: anyNamed('query'),
      pageSize: anyNamed('pageSize'),
      page: anyNamed('page'),
    )).thenAnswer((_) async => [image]);

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
    )).thenAnswer((_) async => [image]);

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
    )).thenThrow(
      DioException(
        requestOptions: RequestOptions(),
        response: Response(
            requestOptions: RequestOptions(), data: 'Failed to load images'),
      ),
    );

    await viewModel.fetchPage(1);

    expect(viewModel.controller.error, 'Failed to load images');
  });
}
