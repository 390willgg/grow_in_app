import 'package:grow_in_app/features/auth/domain/entities/first_page/first_page.dart';

import '../repositories/auth_repository.dart';

class FirstPageUseCase {
  final AuthRepository _authRepository;

  FirstPageUseCase(this._authRepository);

  FirstPage call() {
    return _authRepository.firstPage();
  }
}
