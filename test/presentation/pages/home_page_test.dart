import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/pages/home_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockHomeViewModel mockViewModel = MockHomeViewModel();

  final getIt = GetIt.instance;

  setUpAll(() {
    // mockViewModel = MockHomeViewModel();
    getIt.registerSingleton<HomeViewModel>(mockViewModel);
    provideDummy<HomeViewModelState>(const Success());

    // Stub the state method to return a valid HomeViewModelState
    when(mockViewModel.state).thenReturn(const Success());

    // Stub the stream method to return a valid stream
    when(mockViewModel.stream).thenAnswer((_) => Stream.value(const Success()));
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<HomeViewModel>(
      create: (_) => mockViewModel,
      child: const MaterialApp(home: HomePage()),
    );
  }

  testWidgets('HomePage displays search bar', (WidgetTester tester) async {
    when(mockViewModel.controller)
        .thenReturn(PagingController<int, ImageEntity>(firstPageKey: 1));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('HomePage displays images in grid', (WidgetTester tester) async {
    final image = createImage();

    // Stub the controller method to return a valid PagingController
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.itemList = [image];

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(PagedGridView<int, ImageEntity>), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('HomePage shows error message on error',
      (WidgetTester tester) async {
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.error = 'Error loading images';

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error loading images'), findsOneWidget);
  });

  testWidgets('HomePage shows no results message when no items found',
      (WidgetTester tester) async {
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.itemList = [];

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(PagedGridView<int, ImageEntity>), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsNothing);
  });

  testWidgets('Tapping on an image navigates to detail page',
      (WidgetTester tester) async {
    final image = createImage();
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.itemList = [image];

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(CachedNetworkImage));

    verify(mockViewModel.navigateToDetail(image)).called(1);
  });
}
