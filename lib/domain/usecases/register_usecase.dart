import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

class RegisterUseCase extends UseCase<void, RegisterParams> {
  final AuthRepository repository;
  
  RegisterUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    return await repository.register(
      params.email, 
      params.name, 
      params.password, 
      params.phone
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final String phone;
  
  const RegisterParams({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });
  
  @override
  List<Object> get props => [email, name, password, phone];
}