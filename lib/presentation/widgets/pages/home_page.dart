import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/components/error_card.dart';
import 'package:images/presentation/widgets/components/error_placehoder.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage
    extends RootPageStateful<ImageListViewState, ImageListViewmodel> {
  const HomePage({super.key});

  @override
  RootScreenState<ImageListViewState, ImageListViewmodel, HomePage>
      createState() => _HomePageState();
}

class _HomePageState
    extends RootScreenState<ImageListViewState, ImageListViewmodel, HomePage> {
  @override
  void listenState(BuildContext context, ImageListViewState state) {
    if (state is Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget buildView(
    BuildContext context,
    ImageListViewState state,
    ImageListViewmodel viewModel,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: PagedGridView<int, ImageEntity>(
        pagingController: viewModel.controller,
        builderDelegate: PagedChildBuilderDelegate<ImageEntity>(
          itemBuilder: _getItem,
          firstPageErrorIndicatorBuilder: (context) => ErrorCard(
            message: 'Error loading page', // TODO: Localize
            onRetry: viewModel.loadItems,
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
            child: ErrorPlacehoder(
              title: 'Home Page', // TODO localize
              subtitle: 'empty list', // TODO localize
              icon: Icons.search,
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorCard(
            message: 'New page error', // TODO: Localize
            onRetry: viewModel.controller.retryLastFailedRequest,
          ),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          mainAxisExtent: 200,
        ),
      ),
    );
  }

  Widget _getItem(BuildContext context, ImageEntity image, int index) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: CachedNetworkImage(
          imageUrl: image.url,
          placeholder: (context, url) => Container(
            height: 200.0,
            width: double.infinity,
            color: Colors.grey[200],
            child: Icon(
              Icons.image,
              size: 50.0,
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            size: 50.0,
            color: Colors.red.withOpacity(0.4),
          ),
          height: 200.0,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
