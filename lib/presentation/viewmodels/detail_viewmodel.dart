import 'package:images/presentation/viewmodels/root_viewmodel.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DetailViewModel extends RootViewModel<DetailViewState> {
  DetailViewModel() : super(const Success());
}

sealed class DetailViewState extends ViewState {
  const DetailViewState();
}

class Loading extends DetailViewState {
  const Loading();
}

class Error extends DetailViewState {
  final String message;

  const Error(this.message);
}

class Success extends DetailViewState {
  const Success();
}
