import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

class LogoutUseCase extends UseCaseWithoutParams<void> {
  final AuthRepository repository;
  
  LogoutUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}