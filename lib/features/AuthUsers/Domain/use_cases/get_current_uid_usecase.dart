import 'package:proyecto_c2/features/AuthUsers/Domain/repositories/firebase_repository.dart';

class GetCurrentUIDUseCase {
  final AuthFirebaseRepository repository;

  GetCurrentUIDUseCase({required this.repository});
  Future<int> call() async {
    return await repository.getCurrentUId();
  }
}
