import 'package:images/domain/entities/image_entity.dart';
import 'package:images/domain/usecases/get_images_usecase.dart';
import 'package:images/presentation/viewmodels/root_viewmodel.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HomeViewModel extends RootViewModel<ImageListViewState> {
  static const _pageSize = 10;

  final PagingController<int, ImageEntity> _pagingController =
      PagingController(firstPageKey: 1);
  String _query = '';

  PagingController<int, ImageEntity> get controller => _pagingController;

  HomeViewModel(
    this.getImagesUseCase,
  ) : super(const Success()) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void dispose() {
    _pagingController.dispose();
  }

  final GetImagesUseCase getImagesUseCase;

  Future<void> loadItems() async {
    _pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getImagesUseCase(
        query: _query,
        pageSize: _pageSize,
        page: pageKey,
      );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void search(String value) {
    _query = value;
    _pagingController.refresh();
  }
}

sealed class ImageListViewState extends ViewState {
  const ImageListViewState();
}

class Loading extends ImageListViewState {
  const Loading();
}

class Error extends ImageListViewState {
  final String message;

  const Error(this.message);
}

class Success extends ImageListViewState {
  const Success();
}
