import 'package:flutter/material.dart';
import 'package:images/presentation/viewmodels/detail_viewmodel.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';

class DetailPage extends RootPage<DetailViewState, DetailViewModel> {
  const DetailPage({super.key});

  @override
  Widget buildView(
    BuildContext context,
    DetailViewState state,
    DetailViewModel viewModel,
  ) {
    return const Scaffold(
      body: Center(
        child: Text('Detail Page'),
      ),
    );
  }
}
