import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:images/domain/entities/image_entity.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/components/error_card.dart';
import 'package:images/presentation/widgets/components/error_placehoder.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends RootPageStateful<HomeViewModelState, HomeViewModel> {
  const HomePage({super.key});

  @override
  RootScreenState<HomeViewModelState, HomeViewModel, HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends RootScreenState<HomeViewModelState, HomeViewModel, HomePage> {
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
    HomeViewModelState state,
    HomeViewModel viewModel,
  ) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text('home.title'.tr()),
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
                hintText: 'home.search_hint'.tr(),
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
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: ErrorPlacehoder(
                title: 'home.no_results_title'.tr(),
                subtitle: 'home.no_results_message'.tr(),
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
        child: Stack(
          children: [
            Hero(
              tag: image.id,
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
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => viewModel.navigateToDetail(image),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
