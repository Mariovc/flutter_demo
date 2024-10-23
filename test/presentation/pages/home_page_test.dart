import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/components/error_placehoder.dart';
import 'package:images/presentation/widgets/pages/home_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockHomeViewModel mockViewModel = MockHomeViewModel();

  final getIt = GetIt.instance;

  setUpAll(() async {
    getIt.registerSingleton<HomeViewModel>(mockViewModel);
    SharedPreferences.setMockInitialValues({});
    provideDummy<HomeViewModelState>(const Success());

    // Stub the state method to return a valid HomeViewModelState
    when(mockViewModel.state).thenReturn(const Success());

    // Stub the stream method to return a valid stream
    when(mockViewModel.stream).thenAnswer((_) => Stream.value(const Success()));

    await EasyLocalization.ensureInitialized();
  });

  tearDownAll(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const JsonAssetLoader(),
      child: BlocProvider<HomeViewModel>(
        create: (_) => mockViewModel,
        child: Builder(builder: (context) {
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const HomePage(),
          );
        }),
      ),
    );
  }

  testWidgets('HomePage displays search bar', (WidgetTester tester) async {
    when(mockViewModel.controller)
        .thenReturn(PagingController<int, ImageEntity>(firstPageKey: 1));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('HomePage shows error message on error',
      (WidgetTester tester) async {
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.error = 'Error loading images';

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Error loading images'), findsOneWidget);
  });

  testWidgets('HomePage shows no results message when no items found',
      (WidgetTester tester) async {
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.itemList = [];

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(PagedGridView<int, ImageEntity>), findsOneWidget);
    expect(find.byType(ErrorPlacehoder), findsOneWidget);
  });

  testWidgets('Tapping on an image navigates to detail page',
      (WidgetTester tester) async {
    final image = createImage();
    final pagingController =
        PagingController<int, ImageEntity>(firstPageKey: 1);
    when(mockViewModel.controller).thenReturn(pagingController);
    pagingController.itemList = [image];

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(PagedGridView<int, ImageEntity>), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    await tester.tap(find.byType(CachedNetworkImage));

    verify(mockViewModel.navigateToDetail(image)).called(1);
  });
}
