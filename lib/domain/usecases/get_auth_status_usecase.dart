import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

class GetAuthStatusUseCase extends UseCaseWithoutParams<bool> {
  final AuthRepository repository;
  
  GetAuthStatusUseCase(this.repository);
  
  @override
  Future<Either<Failure, bool>> call() async {
    return await repository.isLoggedIn();
  }
}