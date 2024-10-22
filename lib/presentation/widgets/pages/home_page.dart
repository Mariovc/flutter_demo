import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/components/error_card.dart';
import 'package:images/presentation/widgets/components/error_placehoder.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends RootPageStateful<ImageListViewState, HomeViewModel> {
  const HomePage({super.key});

  @override
  RootScreenState<ImageListViewState, HomeViewModel, HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends RootScreenState<ImageListViewState, HomeViewModel, HomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
    _focusNode.dispose();
  }

  @override
  Widget buildView(
    BuildContext context,
    ImageListViewState state,
    HomeViewModel viewModel,
  ) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: const Text('Home Page'),
            forceElevated: innerBoxIsScrolled,
          ),
          SliverAppBar(
            primary: false,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            title: TextField(
              focusNode: _focusNode,
              onTapOutside: (event) => _focusNode.unfocus(),
              decoration: InputDecoration(
                hintText: 'Search ...',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              textCapitalization: TextCapitalization.sentences,
              onChanged: viewModel.search,
            ),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(8), child: SizedBox()),
          )
        ],
        body: PagedGridView<int, ImageEntity>(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          pagingController: viewModel.controller,
          builderDelegate: PagedChildBuilderDelegate<ImageEntity>(
            itemBuilder: _getItem,
            firstPageErrorIndicatorBuilder: (context) => ErrorCard(
              message: viewModel.controller.error,
              onRetry: viewModel.loadItems,
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: ErrorPlacehoder(
                title: 'No results found', // TODO localize
                subtitle:
                    'Try searching with different keywords.', // TODO localize
                icon: Icons.search,
              ),
            ),
            newPageErrorIndicatorBuilder: (context) => ErrorCard(
              message: viewModel.controller.error,
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
        child: InkWell(
          onTap: viewModel.navigateToDetail,
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
      ),
    );
  }
}
